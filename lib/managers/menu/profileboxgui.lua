ProfileBoxGui = ProfileBoxGui or class( TextBoxGui )

function ProfileBoxGui:init( ws, title, text, content_data, config )
	config = config or {}
	config.h = config.h or 260
	config.w = config.w or 280
	local x,y = ws:size()
	config.x = config.x or 0  -- x - config.w 
	config.y = config.y or (y - config.h - CoreMenuRenderer.Renderer.border_height)
	config.no_close_legend = true
	config.no_scroll_legend = true
	config.use_minimize_legend = true
	title = "Profile"
	-- self._default_font_size = tweak_data.menu.default_font_size
	-- self._topic_state_font_size = 22
	self._stats_font_size = 14
	self._stats_items = self._stats_items or {}
			
	ProfileBoxGui.super.init( self, ws, title, text, content_data, config )
		
	self:set_layer( 10 )
end

function ProfileBoxGui:_profile_name()
	return managers.network.account:username()
end

function ProfileBoxGui:_profile_level()
	return ""..managers.experience:current_level()
end

function ProfileBoxGui:update( t, dt )
	local name_panel = self._scroll_panel:child( "profile_panel" ):child( "name_panel" )
	local name = name_panel:child( "name" )
	if name:w() > name_panel:w() then
		if self._name_right then
			if name:x() < 0 then
				name:set_x( name:x() + dt * 10 )
			else
				self._name_right = false
			end
		elseif name:right() > name_panel:w() then
			name:set_x( name:x() - dt * 10 )
		else
			self._name_right = true
		end
	end
end

function ProfileBoxGui:_create_text_box( ws, title, text, content_data, config )
	ProfileBoxGui.super._create_text_box( self, ws, title, text, content_data, config )
		
	local profile_panel = self._scroll_panel:panel( { name = "profile_panel", x = 0, h = 600, w = self._scroll_panel:w(), layer = 1 } )
	
	local texture, rect = tweak_data.hud_icons:get_icon_data( table.random( { "mask_clown", "mask_alien"} )..math.random( 4 ) )
	local avatar = profile_panel:bitmap( { name = "avatar", visible = true, texture = texture, texture_rect = rect, layer = 0, x = 0, y = 10 } )
	-- profile_panel:bitmap( { name = "avatar_indicator", visible = false, texture = texture, texture_rect = rect, layer = 1, x = 0, y = 10, blend_mode = "add" } )
	profile_panel:gradient( { name = "avatar_indicator", visible = false, orientation = "vertical", gradient_points = { 0, Color( 0,255/255,168/255,0), 0.5, Color( 0,154/255,102/255,0), 1, Color( 1,0.8,50/255,0) }, layer = 1, x = 0, y = 10, w = avatar:w(), h = avatar:h(), blend_mode = "add" } )
	
	-- local name_panel = profile_panel:panel( { name = "name_panel", w = 160 } )
	local name_panel = profile_panel:panel( { name = "name_panel", w = self._panel:w() - (avatar:right() + 16) - 64 } )
	name_panel:set_left( avatar:right() + 16 )
	name_panel:set_y( avatar:y() )
	
	local name = name_panel:text( { name = "name", text = self:_profile_name(), font = tweak_data.menu.pd2_medium_font, font_size = tweak_data.menu.pd2_medium_font_size, x = 0, y = 0,
									align="left", halign="left", vertical="top", hvertical="top",
									color = Color( 0.8, 1, 0.8 ), layer = 0 } )
		local _,_,tw,th = name:text_rect()
		name_panel:set_h( th )
		name:set_h( th )
		-- name:set_left( avatar:right() + 16 )	
		-- name:set_y( avatar:y() )
		name:set_w( tw + 4 )
				
	local level = profile_panel:text( { name = "level", text = self:_profile_level(), font = tweak_data.menu.small_font_noshadow, font_size = tweak_data.menu.small_font_size, x = 16, y = math.round( 0 ),
									align="right", halign="right", vertical="center", hvertical="center", blend_mode="normal",
									color = Color( 0.8, 1, 0.8 ), layer = 0, } )
		local _,_,sw,sh = level:text_rect()
		level:set_size( sw, sh )
		level:set_right( math.floor( profile_panel:w() ) )
		level:set_center_y( math.round( name_panel:center_y() ) )
		
	local texture, rect = tweak_data.hud_icons:get_icon_data( "icon_equipped" )
	local arrow = profile_panel:bitmap( { name = "arrow", visible = false, texture = texture, texture_rect = rect, layer = 0, x = avatar:right() } )
	arrow:set_center_y( name_panel:center_y() )
	
	self:_add_statistics()
		
	-- print( "self._stats_items[ #self._stats_items ]:bottom()", self._stats_items[ #self._stats_items ]:bottom() )
	if #self._stats_items == 0 then
		profile_panel:set_h( 64 + 10 )
	else
		profile_panel:set_h( math.ceil( self._stats_items[ #self._stats_items ]:bottom() ) + 10 )
	end
		
	self._scroll_panel:set_h( math.max( self._scroll_panel:h(), profile_panel:h() ) )
	self:_set_scroll_indicator()
end

function ProfileBoxGui:_add_statistics()
	self:_add_stats( { topic = string.upper( "Achievements:" ), name = "achievements", data =  managers.achievment:total_unlocked()/ managers.achievment:total_amount(), text = ""..managers.achievment:total_unlocked().."/"..managers.achievment:total_amount(), type = "progress" })
	self:_add_stats( { topic = managers.localization:text( "menu_stats_level_progress" ), data = managers.experience:current_level()/managers.experience:level_cap(), text = ""..managers.experience:current_level().."/"..managers.experience:level_cap(), type = "progress" })
	self:_add_stats( { topic = managers.localization:text( "menu_stats_money" ), data = managers.experience:total_cash_string(), type = "text" })
	self:_add_stats( { topic = managers.localization:text( "menu_stats_time_played" ), data = managers.statistics:time_played().." "..managers.localization:text( "menu_stats_time" ), type = "text" })
	self:_add_stats( { topic = managers.localization:text( "menu_stats_total_kills" ), data = ""..managers.statistics:total_kills(), type = "text" })
	-- self:_add_stats( { topic = managers.localization:text( "menu_stats_challenges_completion" ), data = managers.challenges:amount_of_completed_challenges()/managers.challenges:amount_of_challenges(), type = "progress" })
end

function ProfileBoxGui:_add_stats( params )
	local y = 64
	for _,panel in ipairs( self._stats_items ) do
		y = y + panel:h() + 4
	end
	
	local xo = 4
	
	local panel = self._scroll_panel:child( "profile_panel" ):panel( { name = params.name, y = y, w = self._scroll_panel:child( "profile_panel" ):w() } )
	
	local topic = panel:text( {
								name="topic", font = tweak_data.menu.small_font, font_size = self._stats_font_size, color = Color.white, layer = 2,
								x = xo, y = 0, w = panel:w(),
								align="left", halign="left", vertical="center", -- valign="center",
								text = params.topic,
							} )
	-- topic:set_debug( true )
	local x,y,w,h = topic:text_rect()
	topic:set_h( math.ceil( h ) )
	panel:set_h( math.ceil( h ) )
	
	if params.type == "text" then
		local text = panel:text( {
									name = "text", font = tweak_data.menu.small_font, font_size = self._stats_font_size, color = Color.white, layer = 2,
									x = -xo, y = 0, h = h, w = self._scroll_panel:child( "profile_panel" ):w(),
									align="right", halign="right", vertical="center", valign="center",
									text = params.data,
								} )
	end
	
	if params.type == "progress" then
		h = h + 4
		topic:set_h( math.ceil( h ) )
		panel:set_h( math.ceil( h ) )
		
		local bg = panel:rect( {	
									name ="bg", x = 0, y = 0, w = panel:w(), h = h,
									-- align="center", halign="center", vertical="center",
									color = Color.black:with_alpha( 0.5 ), --self.row_item_color,
									layer = 0,
								} )
		local bar = panel:gradient( {
									name ="bar", orientation = "vertical",
									gradient_points = { 0, Color( 1,255/255,168/255,0), 1, Color( 1,154/255,102/255,0) },
									x = 0 + 2, y = bg:y() + 2, w = (bg:w() - 4) * params.data, h = bg:h() - 4,
									align="center", halign="center", vertical="center",
									layer = 1,
								} )
		local text = panel:text( {
									name ="bar_text", font = tweak_data.menu.small_font, font_size = self._stats_font_size, color = Color.white, layer = 2,
									x = -xo, y = 0, h = h, w = bg:w(),
									align="right", halign="right", vertical="center", valign="center",
									text = params.text or (""..math.floor( params.data*100 ).."%"),
								} )
	end
	
	table.insert( self._stats_items, panel )
end

function ProfileBoxGui:mouse_pressed( button, x, y )
	if not self:can_take_input() then
		return
	end
	
	if button == Idstring( "0" ) then
		if self._panel:child( "info_area" ):inside( x, y ) then
			local profile_panel = self._scroll_panel:child( "profile_panel" )
			local name_panel = profile_panel:child( "name_panel" )
			if name_panel:inside( x, y ) then
				self:_trigger_stats()
				return true
			elseif profile_panel:child( "avatar" ):inside( x, y ) then
				self:_trigger_profile()
				return true
			elseif profile_panel:child( "achievements" ) and profile_panel:child( "achievements" ):inside( x, y ) then
				self:_trigger_achievements()
				return true
			end
		end
	end
	
end

function ProfileBoxGui:_trigger_stats()
	Steam:overlay_activate( "game", "Stats" )
end

function ProfileBoxGui:_trigger_profile()
	Steam:user( managers.network.account:player_id() ):open_overlay( "steamid" )
	-- Steam:overlay_activate( "game", "Community" )
end

function ProfileBoxGui:_trigger_achievements()
	Steam:overlay_activate( "game", "Achievements" )
end

function ProfileBoxGui:mouse_moved( x, y )
	if not self:can_take_input() then
		return
	end
	
	local pointer = nil
	local inside_info = self._panel:child( "info_area" ):inside( x, y )
	
	local profile_panel = self._scroll_panel:child( "profile_panel" )
	local name_panel = profile_panel:child( "name_panel" )
	
	local inside = inside_info and name_panel:inside( x, y )
	name_panel:child( "name" ):set_color( inside and Color.white or Color( 0.8, 1, 0.8 ) )
	profile_panel:child( "level" ):set_color( inside and Color.white or Color( 0.8, 1, 0.8 ) )
	profile_panel:child( "arrow" ):set_visible( inside )
	pointer = inside and "link" or pointer
	
	local inside = inside_info and profile_panel:child( "avatar" ):inside( x, y )
	-- profile_panel:child( "avatar" ):set_blend_mode( inside and "add" or "normal" )
	profile_panel:child( "avatar_indicator" ):set_visible( inside )
	pointer = inside and "link" or pointer
	
	if profile_panel:child( "achievements" ) then
		local inside = inside_info and profile_panel:child( "achievements" ):inside( x, y )
		profile_panel:child( "achievements" ):child( "topic" ):set_color( inside and Color( 0.8, 1, 0.8 ) or Color.white )
		profile_panel:child( "achievements" ):child( "bar_text" ):set_color( inside and Color( 0.8, 1, 0.8 ) or Color.white )
	-- profile_panel:child( "achievements" ):set_color( inside and Color.white or Color( 0.8, 1, 0.8 ) )
	 
		pointer = inside and "link" or pointer
	end
	
	local inside = inside_info and profile_panel:inside( x, y )
	pointer = pointer or inside and "arrow"
	
	
	return false, pointer
end

function ProfileBoxGui:_check_scroll_indicator_states()
	ProfileBoxGui.super._check_scroll_indicator_states( self )
end

function ProfileBoxGui:set_size( x, y )
	ProfileBoxGui.super.set_size( self, x, y )
	local profile_panel = self._scroll_panel:child( "profile_panel" )
end

function ProfileBoxGui:set_visible( visible )
	ProfileBoxGui.super.set_visible( self, visible )
end

function ProfileBoxGui:close()
	ProfileBoxGui.super.close( self )
end

LobbyProfileBoxGui = LobbyProfileBoxGui or class( ProfileBoxGui )

function LobbyProfileBoxGui:init( ws, title, text, content_data, config, peer_id )
	self._peer_id = peer_id
	LobbyProfileBoxGui.super.init( self, ws, title, text, content_data, config )
end

function LobbyProfileBoxGui:_trigger_stats()
	local peer = managers.network:session():peer( self._peer_id )
	local user = Steam:user( peer:ip() )
	user:open_overlay( "stats" )
end

function LobbyProfileBoxGui:_trigger_profile()
	local peer = managers.network:session():peer( self._peer_id )
	local user = Steam:user( peer:ip() )
	user:open_overlay( "steamid" )
end

function LobbyProfileBoxGui:_trigger_achievements()
	local peer = managers.network:session():peer( self._peer_id )
	local user = Steam:user( peer:ip() )
	user:open_overlay( "achievements" )
end

function LobbyProfileBoxGui:_profile_name()
	return managers.network:session():peer( self._peer_id ):name()
end

function LobbyProfileBoxGui:_profile_level()
	local peer = managers.network:session():peer( self._peer_id )
	local user = Steam:user( peer:ip() )
	return ""..( peer:profile( "level" ) or user:rich_presence( "level" ) )
end

function LobbyProfileBoxGui:_add_statistics()
	-- self:_add_stats( { topic = managers.localization:text( "menu_stats_time_played" ), data = managers.statistics:time_played().." "..managers.localization:text( "menu_stats_time" ), type = "text" })
end

-------------------------------------------------------------------------------
ViewCharacterProfileBoxGui = ViewCharacterProfileBoxGui or class( ProfileBoxGui )

function ViewCharacterProfileBoxGui:init( ws, title, text, content_data, config, user )
	self._user = user
	ViewCharacterProfileBoxGui.super.init( self, ws, title, text, content_data, config )
end

function ViewCharacterProfileBoxGui:_trigger_stats()
	self._user:open_overlay( "stats" )
end

function ViewCharacterProfileBoxGui:_trigger_profile()
	self._user:open_overlay( "steamid" )
end

function ViewCharacterProfileBoxGui:_trigger_achievements()
	self._user:open_overlay( "achievements" )
end

function ViewCharacterProfileBoxGui:_profile_name()
	return self._user:name() -- managers.network:session():peer( self._peer_id ):name()
end

function ViewCharacterProfileBoxGui:_profile_level()
	return ""..self._user:rich_presence( "level" )
end

function ViewCharacterProfileBoxGui:_add_statistics()
	-- self:_add_stats( { topic = managers.localization:text( "menu_stats_time_played" ), data = managers.statistics:time_played().." "..managers.localization:text( "menu_stats_time" ), type = "text" })
end