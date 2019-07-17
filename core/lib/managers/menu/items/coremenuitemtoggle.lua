core:module("CoreMenuItemToggle")
core:import("CoreMenuItem")
core:import("CoreMenuItemOption")

-- Represents an item's toggle data
ItemToggle = ItemToggle or class( CoreMenuItem.Item )
ItemToggle.TYPE = "toggle"

function ItemToggle:init( data_node, parameters )
	CoreMenuItem.Item.init( self, data_node, parameters )
	
	self._type = "toggle"
	
	local params = self._parameters
	
	self.options  = {}
	self.selected = 1

	if( data_node ) then
		for _,c in ipairs( data_node ) do
			local type = c._meta
			-- <option>
			if( type == "option" ) then
				local option = CoreMenuItemOption.ItemOption:new( c )
				self:add_option( option )
			end
		end
	end
end

function ItemToggle:add_option( option )
	table.insert( self.options, option )
end

function ItemToggle:toggle()
	if not self._enabled then
		return
	end
	
	self.selected = self.selected + 1
	
	if( self.selected > #self.options ) then
		self.selected = 1
	end
	self:dirty()
end

function ItemToggle:toggle_back()
	if not self._enabled then
		return
	end
	
	self.selected = self.selected - 1
	
	if( self.selected <= 0 ) then
		self.selected = #self.options
	end
	self:dirty()
end

function ItemToggle:selected_option()
	return self.options[ self.selected ]
end

function ItemToggle:value()
	local value = ""
	local selected_option = self:selected_option()
	if( selected_option ) then
		value = selected_option:parameters().value
	end
	return value
end

function ItemToggle:set_value( value )
	for i, option in ipairs( self.options ) do
		if( option:parameters().value == value ) then
			self.selected = i
			break	
		end
	end
	self:dirty()
end

-- GUI ----------------------------------------------------

function ItemToggle:setup_gui( node, row_item )
	-- local scaled_size = managers.gui_data:scaled_size()
	
	row_item.gui_panel = node.item_panel:panel( { w = node.item_panel:w() } )
	row_item.gui_text = node._text_item_part( node, row_item, row_item.gui_panel, node._right_align( node ) )
	row_item.gui_text:set_text( row_item.to_upper and utf8.to_upper( row_item.text ) or row_item.text )

	if self:parameter( "title_id" ) then
		row_item.gui_title = node._text_item_part( node, row_item, row_item.gui_panel, node._right_align( node ), "right" )
		row_item.gui_title:set_text( managers.localization:text( self:parameter( "title_id" ) ) )
	end
	
    if not self:enabled() then
        row_item.color = _G[ "tweak_data" ].menu.default_disabled_text_color
        row_item.row_item_color = row_item.color
        row_item.gui_text:set_color( row_item.color )
    end
	if self:selected_option():parameters().text_id then -- If text based
		row_item.gui_option = node._text_item_part( node, row_item, row_item.gui_panel, node._left_align( node )  )
		row_item.gui_option:set_align( row_item.align )
	end
	
	if self:selected_option():parameters().icon then -- If icon based
		row_item.gui_icon = row_item.gui_panel:bitmap( { layer = node.layers.items, x = 0, y = 0, texture_rect = { 0, 0, 24, 24 }, texture = self:selected_option():parameters().icon } )
		row_item.gui_icon:set_color( _G[ "tweak_data" ].menu.default_disabled_text_color )
		-- row_item.gui_icon:set_blend_mode( node.row_item_blend_mode )
	end
	
	if row_item.help_text then
		-- node._create_info_panel( node, row_item )
	end
	
	if self:info_panel() == "lobby_campaign" then
		node._set_lobby_campaign( node, row_item )
	end

	-- self:_align_toggle( row_item )
	-- self:reload( row_item, node )
	
	return true
end

local xl_pad = 64
function ItemToggle:reload( row_item, node )
	local safe_rect = managers.gui_data:scaled_size() -- managers.viewport:get_safe_rect_pixels()
	
	row_item.gui_text:set_font_size( node.font_size )
	local x,y,w,h = row_item.gui_text:text_rect()
	
	row_item.gui_text:set_height( h )
	row_item.gui_panel:set_height( h )
	-- row_item.gui_panel:set_w( safe_rect.width )
	-- row_item.gui_panel:set_width( safe_rect.width/2 + xl_pad )
	-- row_item.gui_panel:set_x( safe_rect.width/2 - xl_pad )
	row_item.gui_panel:set_width( safe_rect.width - node._mid_align( node ) )
	row_item.gui_panel:set_x( node._mid_align( node ) )
	
	
	if row_item.gui_option then
		row_item.gui_option:set_font_size( node.font_size )
		row_item.gui_option:set_width( node._left_align( node ) - row_item.gui_panel:x() )
		row_item.gui_option:set_right( node._left_align( node ) - row_item.gui_panel:x() )
		row_item.gui_option:set_height( h )
	end
	
	row_item.gui_text:set_width( safe_rect.width/2 )
	
	if( row_item.align == "right" ) then
		row_item.gui_text:set_right( row_item.gui_panel:w() )
	else
		row_item.gui_text:set_left( node._right_align( node )  - row_item.gui_panel:x() + (self:parameters().expand_value or 0) )
	end
	
	if row_item.gui_icon then
		row_item.gui_icon:set_w( h )	
		row_item.gui_icon:set_h( h )
		-- row_item.gui_icon:set_right( node._left_align( node ) - row_item.gui_panel:x() )
		
		if( row_item.align == "right" ) then
			row_item.gui_icon:set_left( node._right_align( node )  - row_item.gui_panel:x() + (self:parameters().expand_value or 0) )
		else
			row_item.gui_icon:set_right( row_item.gui_panel:w() )
		end
	end

	-- row_item.gui_panel:set_width( (row_item.gui_option and row_item.gui_option:width() or 0 )+ row_item.gui_text:width() + node._align_line_padding * 2 )
	
	if row_item.gui_title then
		row_item.gui_title:set_font_size( node.font_size )
		row_item.gui_title:set_height( h )
		
		if row_item.gui_icon then
			row_item.gui_title:set_right( row_item.gui_icon:left() - node._align_line_padding * 2 )
		else
			row_item.gui_title:set_right( node._left_align( node ) )
		end
	end
	
	if row_item.gui_info_panel then
		if self:info_panel() == "lobby_campaign" then
			node._align_lobby_campaign( node, row_item )
		else
			node._align_info_panel( node, row_item )
		end
	end
	
	if row_item.gui_option then
		if node.localize_strings and self:selected_option():parameters().localize ~= false then 
			row_item.option_text = managers.localization:text( self:selected_option():parameters().text_id )
		else
			row_item.option_text = self:selected_option():parameters().text_id
		end
		row_item.gui_option:set_text( row_item.option_text )
	end
	
	self:_set_toggle_item_image( row_item )
	
	if self:info_panel() == "lobby_campaign" then
		node._reload_lobby_campaign( node, row_item )
	end
		
	return true
end

function ItemToggle:_set_toggle_item_image( row_item )
	if self:selected_option():parameters().icon then
		if row_item.highlighted and self:selected_option():parameters().s_icon then
			local x = self:selected_option():parameters().s_x
			local y = self:selected_option():parameters().s_y
			local w = self:selected_option():parameters().s_w
			local h = self:selected_option():parameters().s_h
			row_item.gui_icon:set_image( self:selected_option():parameters().s_icon, x, y, w, h )
		else
			local x = self:selected_option():parameters().x
			local y = self:selected_option():parameters().y
			local w = self:selected_option():parameters().w
			local h = self:selected_option():parameters().h
			row_item.gui_icon:set_image( self:selected_option():parameters().icon, x, y, w, h )
		end
		if self:enabled() then
			row_item.gui_icon:set_color( Color.white )
		else
			row_item.gui_icon:set_color( _G[ "tweak_data" ].menu.default_disabled_text_color )
		end
	end 
end

function ItemToggle:highlight_row_item( node, row_item, mouse_over )
	row_item.gui_text:set_color( row_item.color )
	row_item.gui_text:set_font( (row_item.font and Idstring(row_item.font)) or _G[ "tweak_data" ].menu.default_font_no_outline_id )
	
	row_item.highlighted = true
	self:_set_toggle_item_image( row_item )
		
	if row_item.gui_option then
		row_item.gui_option:set_color( row_item.color )
	end
	if row_item.gui_info_panel then
		row_item.gui_info_panel:set_visible( true )
	end
	
	if self:info_panel() == "lobby_campaign" then
		node._highlight_lobby_campaign( node, row_item )
	end
	
	return true
end

function ItemToggle:fade_row_item( node, row_item )
	row_item.gui_text:set_color( row_item.color )
	row_item.gui_text:set_font( (row_item.font and Idstring(row_item.font)) or _G[ "tweak_data" ].menu.default_font_id )
	
	row_item.highlighted = nil
	self:_set_toggle_item_image( row_item )
	
	if row_item.gui_option then
		row_item.gui_option:set_color( row_item.color )
	end
	
	if row_item.gui_info_panel then
		row_item.gui_info_panel:set_visible( false )
	end
	
	if self:info_panel() == "lobby_campaign" then
		node._fade_lobby_campaign( node, row_item )
		end
	return true
end