ExperienceManager = ExperienceManager or class()
-- ExperienceManager.PATH = "gamedata/objectives"
-- ExperienceManager.FILE_EXTENSION = "objective"
-- ExperienceManager.FULL_PATH = ExperienceManager.PATH .. "." .. ExperienceManager.FILE_EXTENSION

function ExperienceManager:init()
	self:_setup()
end

-- Some experience data is kept between levels (if not saved and loaded to profile)
function ExperienceManager:_setup()
	self._total_levels = #tweak_data.experience_manager.levels
	if not Global.experience_manager then
		Global.experience_manager = {}
		Global.experience_manager.total = 0
		Global.experience_manager.level = 0
		-- Global.experience_manager.next_level_data = {}
	end
	self._global = Global.experience_manager
	
	if not self._global.next_level_data then
		self:_set_next_level_data( 1 )
		-- managers.upgrades:set_target_upgrade_by_level( self._global.level + 1 )
	end
	
	self._cash_tousand_separator = managers.localization:text( "cash_tousand_separator" )
	self._cash_sign = managers.localization:text( "cash_sign" )

	
	-- self:_set_next_level_data( self._global.level + 1 )
	-- managers.upgrades:set_target_upgrade_by_level( self._global.level + 1 )
	self:present()
end

function ExperienceManager:_set_next_level_data( level )
	if level > self._total_levels then
		Application:error( "Reached the level cap" )
		return
	end
	local level_data = tweak_data.experience_manager.levels[ level ]
	self._global.next_level_data 					= {}
	self._global.next_level_data.points 			= level_data.points
	self._global.next_level_data.current_points		= 0
	
	if( self._experience_progress_data ) then
		table.insert( self._experience_progress_data, { level=level, current=0, total=level_data.points } )
	end
	
	-- managers.upgrades:set_target_upgrade_by_level( level )
end

function ExperienceManager:next_level_data()
	return self._global and self._global.next_level_data
end

function ExperienceManager:perform_action_interact( name )
--[[
	if not tweak_data.experience_manager.actions.interact[ name:key() ] then
		return
	end
	
	local size = tweak_data.experience_manager.actions.interact[ name:key() ]
	
	local points = tweak_data.experience_manager.values[ size ]
	if not points then
		Application:error( "Unknown size \"" .. tostring( size ) .. " in experience manager." )
		return
	end
		
	managers.statistics:recieved_experience( { action = action, size = size } )
	self:add_points( points, true )
]]
end


function ExperienceManager:perform_action( action )
	if managers.platform:presence() ~= "Playing" and managers.platform:presence() ~= "Mission_end" then
		return
	end
	
	if not tweak_data.experience_manager.actions[ action ] then
		Application:error( "Unknown action \"" .. tostring( action ) .. " in experience manager." )
		return
	end
	
	local size = tweak_data.experience_manager.actions[ action ]
	
	local points = tweak_data.experience_manager.values[ size ]
	if not points then
		Application:error( "Unknown size \"" .. tostring( size ) .. " in experience manager." )
		return
	end
		
	managers.statistics:recieved_experience( { action = action, size = size } )
	self:add_points( points, true )
end

function ExperienceManager:debug_add_points( points, present_xp )
	self:add_points( points, present_xp, true )
end

function ExperienceManager:give_experience( xp )
	self._experience_progress_data = {}
	self._experience_progress_data.gained = xp
	
	self._experience_progress_data.start_t = {}
	self._experience_progress_data.start_t.level = (self._global.level or 0)
	self._experience_progress_data.start_t.current = self._global.next_level_data and self._global.next_level_data.current_points or 0
	self._experience_progress_data.start_t.total = self._global.next_level_data and self._global.next_level_data.points or 1
	self._experience_progress_data.start_t.xp = self._global.xp_gained or 0
	
	table.insert( self._experience_progress_data, { level=self._global.level+1, current=self._global.next_level_data.current_points, total=self._global.next_level_data.points } )
	
	local level_cap_xp_leftover = self:add_points( xp, true, false )
	if( level_cap_xp_leftover ) then
		self._experience_progress_data.gained = self._experience_progress_data.gained - level_cap_xp_leftover
	end
	
	self._experience_progress_data.end_t = {}
	self._experience_progress_data.end_t.level = (self._global.level or 0)
	self._experience_progress_data.end_t.current = self._global.next_level_data and self._global.next_level_data.current_points or 0
	self._experience_progress_data.end_t.total = self._global.next_level_data and self._global.next_level_data.points or 1
	self._experience_progress_data.end_t.xp = self._global.xp_gained or 0
	
	table.remove( self._experience_progress_data, #self._experience_progress_data )
	
	local return_data = deep_clone( self._experience_progress_data )
	self._experience_progress_data = nil
	
	return return_data
end

function ExperienceManager:add_points( points, present_xp, debug )
	if not debug and managers.platform:presence() ~= "Playing" and managers.platform:presence() ~= "Mission_end" then
		return
	end
	
	-- points = math.floor( points * multiplier )
	
	if not managers.dlc:has_full_game() and self._global.level >= 10 then
		self._global.total = self._global.total + points
		self._global.next_level_data.current_points = 0
		self:present()
		managers.challenges:aquired_money()
		managers.statistics:aquired_money( points )
		return points
	end
	
	
	if self._global.level >= self:level_cap() then
		self._global.total = self._global.total + points
		managers.challenges:aquired_money()
		managers.statistics:aquired_money( points )
		return points
	end
		
	if present_xp then
		self:_present_xp( points )
	end
	
	local points_left = (self._global.next_level_data.points - self._global.next_level_data.current_points)
	if points_left > points then
		self._global.total = self._global.total + points
		self._global.xp_gained = self._global.total
		self._global.next_level_data.current_points = self._global.next_level_data.current_points + points
		self:present()
		managers.challenges:aquired_money()
		managers.statistics:aquired_money( points )
		return
	end
	
	-- Gonna level up
	self._global.total = self._global.total + points_left
	self._global.xp_gained = self._global.total
	self._global.next_level_data.current_points = self._global.next_level_data.current_points + points_left
	self:present()
	self:_level_up()
	managers.statistics:aquired_money( points_left )
	
-- if (points-points_left) > 0 then
	return self:add_points( (points-points_left), present_xp, debug ) -- Add rest of the points to the next level
-- end
end

function ExperienceManager:_level_up()
	-- local target_tree = managers.upgrades:current_tree()
	-- managers.upgrades:aquire_target()
	
	self._global.level = self._global.level + 1
	self:_set_next_level_data( self._global.level + 1 )
	local player = managers.player:player_unit()
	if alive( player ) and tweak_data:difficulty_to_index( Global.game_settings.difficulty ) < 4 then
 		player:base():replenish()
	end
	managers.challenges:check_active_challenges()
	self:_check_achievements()
	
	--[[if managers.groupai:state():is_AI_enabled() then -- TODO(nikmyr): is_AI_enabled is to see if its not in the end screen, surely this can be done better?	
		if target_tree == 1 and managers.groupai:state():get_assault_mode() then
			managers.challenges:set_flag( "aint_afraid" )
		elseif target_tree == 2 and managers.statistics._last_kill == "sniper" then
			managers.challenges:set_flag( "crack_bang" )
		elseif target_tree == 3 and managers.achievment:get_script_data( "player_reviving" ) then
			managers.challenges:set_flag( "lay_on_hands" )
		end
	end]]
	
	if managers.network:session() then
		managers.network:session():send_to_peers_synched( "sync_level_up", managers.network:session():local_peer():id(), self._global.level )
	end
	
	if self._global.level >= 145 then
		managers.challenges:set_flag( "president" )
	end
	
	managers.upgrades:level_up()
	managers.skilltree:level_up()
end

function ExperienceManager:_check_achievements()
	if self._global.level >= tweak_data.achievement.you_gotta_start_somewhere then
		managers.achievment:award( "you_gotta_start_somewhere" )
	end
	if self._global.level >= tweak_data.achievement.guilty_of_crime then
		managers.achievment:award( "guilty_of_crime" )
	end
	if self._global.level >= tweak_data.achievement.gone_in_30_seconds then
		managers.achievment:award( "gone_in_30_seconds" )
	end
	if self._global.level >= tweak_data.achievement.armed_and_dangerous then
		managers.achievment:award( "armed_and_dangerous" )
	end
	if self._global.level >= tweak_data.achievement.big_shot then
		managers.achievment:award( "big_shot" )
	end
	if self._global.level >= tweak_data.achievement.most_wanted then
		managers.achievment:award( "most_wanted" )
	end
end

function ExperienceManager:present()
	
end

function ExperienceManager:_present_xp( amount )
	-- print( "Recieved money:", amount, "Total now:", self._total )
		
	-- Specify this in tweak data later
	local event = "money_collect_small"
	if amount > 999 then
		event = "money_collect_large"
	elseif amount > 101 then
		event = "money_collect_medium"
	end
	
	-- managers.hud:present_text( { text = self:cash_string( amount ) ..managers.localization:text( "gain_xp_postfix" ), time = 0.75, event = event } )
end

function ExperienceManager:current_level()
	return self._global.level
end

function ExperienceManager:level_to_stars()
	local player_stars = math.max( math.ceil( self._global.level / 10 ), 1 )
	return player_stars
end

function ExperienceManager:xp_gained()
	return self._global.xp_gained
end


function ExperienceManager:total()
	return self._global.total
end


function ExperienceManager:cash_string( cash )
	local sign = ""
	if cash < 0 then
		sign = "-"
	end

	local total = tostring( math.round( math.abs( cash ) ) )
	local reverse = string.reverse( total )
	local s = ""
	for i = 1, string.len( reverse ) do
		s = s..string.sub( reverse, i, i )..((math.mod( i, 3 ) == 0 and (i ~= string.len( reverse )) and self._cash_tousand_separator) or "")
	end
	return sign .. self._cash_sign .. string.reverse( s )
end

function ExperienceManager:total_cash_string()
	return self:cash_string( self._global.total ) .. ( self._global.total > 0 and (self._cash_tousand_separator .. "000") or "" )
end

-- Returns a sorted ipairs with all actions
function ExperienceManager:actions()
	local t = {}
	for action,_ in pairs( tweak_data.experience_manager.actions ) do
		table.insert( t, action )
	end
	table.sort ( t )
	return t
end

function ExperienceManager:get_job_xp_by_stars( stars )
	local amount = tweak_data.experience_manager.job_completion[ stars ]
	return amount
end

function ExperienceManager:get_stage_xp_by_stars( stars )
	local amount = tweak_data.experience_manager.stage_completion[ stars ]
	return amount
end

function ExperienceManager:get_contract_difficulty_multiplier( stars ) -- stars are 0 - 3
	local multiplier = tweak_data.experience_manager.difficulty_multiplier[ stars ]
	return multiplier or 0
end

function ExperienceManager:get_current_stage_xp_by_stars( stars, diff_stars )
	local amount = self:get_stage_xp_by_stars( stars ) + self:get_stage_xp_by_stars( stars ) * self:get_contract_difficulty_multiplier( diff_stars )
	return amount
end

function ExperienceManager:get_current_job_xp_by_stars( stars, diff_stars )
	local amount = self:get_job_xp_by_stars( stars ) + self:get_job_xp_by_stars( stars ) * self:get_contract_difficulty_multiplier( diff_stars )
	return amount
end

function ExperienceManager:get_current_job_day_multiplier()
	if not managers.job:has_active_job() then
		return 1
	end
	
	local current_job_day = managers.job:current_stage()
	local is_current_job_professional = managers.job:is_current_job_professional()
	
	local tweak = is_current_job_professional and tweak_data.experience_manager.pro_day_multiplier or tweak_data.experience_manager.day_multiplier
	return tweak and tweak[current_job_day] or 1
end

-- Return the experience amount that would be given to the player if he successfully completes a level (day r day + contract)
function ExperienceManager:get_on_completion_xp()
	local has_active_job = managers.job:has_active_job()
	local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
	local job_stars = has_active_job and managers.job:current_job_stars() or 1
	local difficulty_stars = job_and_difficulty_stars - job_stars
	local on_last_stage = managers.job:on_last_stage()
	
	local amount = self:get_current_stage_xp_by_stars( job_stars, difficulty_stars )
	if on_last_stage then
		amount = amount + self:get_current_job_xp_by_stars( job_stars, difficulty_stars )
	end
	return amount
end

---------------------------------------------------------------------

function ExperienceManager:level_cap()
	return 25
end

function ExperienceManager:reached_level_cap()
	return self._global.level >= self:level_cap()
end

---------------------------------------------------------------------

function ExperienceManager:save( data )
	local state = {	
			total 			= self._global.total,
			xp_gained 			= self._global.xp_gained,
			next_level_data = self._global.next_level_data,
			level 			= self._global.level,
	}
	data.ExperienceManager = state
end

function ExperienceManager:load( data )
	local state = data.ExperienceManager
	if state then
		self._global.total 				= state.total
		self._global.xp_gained 		= state.xp_gained or state.total
		self._global.next_level_data	= state.next_level_data
		self._global.level				= state.level or 0
		
		self._global.level = math.min( self._global.level, self:level_cap() )
	
		--[[local level = 0
		for _, lvl in ipairs( managers.upgrades._global.progress ) do
			level = level + lvl
		end
	
		self._global.level = level]]
		
		for level = 1, self._global.level do
			managers.upgrades:aquire_from_level_tree( level, true )
		end
		
		if not self._global.next_level_data or not tweak_data.experience_manager.levels[ self._global.level + 1 ] or self._global.next_level_data.points ~= tweak_data.experience_manager.levels[ self._global.level + 1 ].points then
			self:_set_next_level_data( self._global.level + 1 )
		end
	end
	
	managers.network.account:experience_loaded()
end

function ExperienceManager:reset()
	managers.upgrades:reset()
	managers.player:reset()
	Global.experience_manager = nil
	self:_setup()
end

---------------------------------------------------------------------

function ExperienceManager:chk_ask_use_backup( savegame_data, backup_savegame_data )
	local savegame_exp_total, backup_savegame_exp_total
	
	local state = savegame_data.ExperienceManager
	if state then
		savegame_exp_total = state.total
	end
	
	state = backup_savegame_data.ExperienceManager
	if state then
		backup_savegame_exp_total = state.total
	end
	
	if savegame_exp_total and backup_savegame_exp_total and savegame_exp_total < backup_savegame_exp_total then
		return true
	end
end