HintManager = HintManager or class()
HintManager.PATH = "gamedata/hints"
HintManager.FILE_EXTENSION = "hint"
HintManager.FULL_PATH = HintManager.PATH .. "." .. HintManager.FILE_EXTENSION

-- Hints are stored Global to keep between levels
function HintManager:init()
	if not Global.hint_manager then
		Global.hint_manager = { hints = {} }
		self:_parse_hints()
	end
	self._cooldown = {}
end

function HintManager:_parse_hints()
	local list = PackageManager:script_data( self.FILE_EXTENSION:id(), self.PATH:id() )

	for _,data in ipairs( list ) do
		if( data._meta == "hint" ) then
		 	self:_parse_hint( data )
		else
			Application:error( "Unknown node \"" .. tostring( data._meta ) .. "\" in \"" .. self.FULL_PATH .. "\". Expected \"objective\" node." )
		end
	end	
end

function HintManager:_parse_hint( data )
	local id =	data.id
	local text_id = data.text_id
	
	local trigger_times = data.trigger_times
	local sync = data.sync
	local event = data.event
	local level = data.level
	
	Global.hint_manager.hints[ id ] = { text_id 		= text_id,
										trigger_times	= trigger_times,
										trigger_count	= 0,
										sync			= sync,
										event			= event,
										level			= level,
										 }
end

-- Returns a sorted ipairs with all ids
function HintManager:ids()
	local t = {}
	for id,_ in pairs( Global.hint_manager.hints ) do
		table.insert( t, id )
	end
	table.sort ( t )
	return t
end

function HintManager:hints()
	return Global.hint_manager.hints
end

function HintManager:hint( id )
	return Global.hint_manager.hints[ id ]
end

function HintManager:show_hint( id, time, only_sync, params )
	if not id or not self:hint( id ) then
		Application:stack_dump_error( "Bad id to show hint, "..tostring( id ).."." )
		return
	end
	
	if not only_sync then
		self:_show_hint( id, time, params )
	end
		
	if self:hint( id ).sync then
		-- if params then
		-- 	Application:stack_dump_error( "A hint can not be network synced while also taking parameters, "..tostring( id ).."." )
		--	return	
		--else
			managers.network:session():send_to_peers_synched( "sync_show_hint", id )
		--end
	end 
end

function HintManager:_show_hint( id, time, params )
	-- Don't show if there is a level limit and current level is larger or equal to limit
	if self:hint( id ).level and managers.experience:current_level() >= self:hint( id ).level then
		return
	end
	
	if self:hint( id ).stop_at_level and managers.experience:current_level() < self:hint( id ).stop_at_level then
		return
	end 
	
	if self._cooldown[ id ] and self._cooldown[ id ] > Application:time() then
		return
	end
	
	-- Trigger if unlimted or if trigger count not reach trigger trimes
	if not self:hint( id ).trigger_times or (self:hint( id ).trigger_times ~= self:hint( id ).trigger_count) then
		self._cooldown[ id ] = Application:time() + 2
		self:hint( id ).trigger_count = self:hint( id ).trigger_count + 1
		self._last_shown_id = id
		managers.hud:show_hint( { text = managers.localization:text( self:hint( id ).text_id, params ), event = self:hint( id ).event, time = time } )
	end 
end

function HintManager:sync_show_hint( id )
	self:_show_hint( id, nil, { BTN_INTERACT = managers.localization:btn_macro( "interact" ) } )
end

function HintManager:last_shown_id()
	return self._last_shown_id
end

function HintManager:on_simulation_ended()
	for _,hint in pairs( Global.hint_manager.hints ) do
		if hint.trigger_times then
			hint.trigger_count = 0
		end
	end
end

function HintManager:save( data )
	local state = {
		hints = deep_clone( Global.hint_manager.hints ),
	}

	data.HintManager = state
end

function HintManager:load( data )
	local state = data.HintManager

	Global.hint_manager.hints = deep_clone( state.hints )
end