---------------------------------------------------------------------------------------------------------------------
--                                                                                                                 --
--   T H I S   F I L E   I S   D E P R E C A T E D !                                                               --
--                                                                                                                 --
--   D O   N O T   A D D   A N Y T H I N G   N E W !   U S E   ' c o r e / u t i l s / c o r e e w s . l u a ' .   --
--                                                                                                                 --
---------------------------------------------------------------------------------------------------------------------

require "core/lib/utils/dev/ews/CoreExtendedMultichoiceDialog"
require "core/lib/utils/dev/ews/CoreCollapseBox"
require "core/lib/utils/dev/ews/CoreXMLTextCtrl"
require "core/lib/utils/dev/ews/CoreCommandRegistry"

CoreEWS = CoreEWS or class()

CoreEWS.TIP_MAX_LEN = 512

function CoreEWS.image_path(file_name)
	file_name = file_name or ""
	
	-- Start looking for the file in the game-specific image directory
	-- If called without an argument, simply returns the game-specific UI image path
	local base_path = managers.database and managers.database:base_path() or (Application:base_path() .. ( arg_value("-assetslocation") or "../../" ) ..  "assets\\")
	local path = base_path .. "lib\\utils\\dev\\ews\\images\\"
	
	if file_name ~= "" and EWS and not EWS:system_file_exists(path .. file_name) then
		-- No game-specific image found - return the path to the image in the core image directory
		-- Note that no check is performed as to whether or not this file exists
		path = base_path .. "core\\lib\\utils\\dev\\ews\\images\\"
	end

	return path .. file_name
end

-- for comments to be included in the news feed, 
-- use <category>Text message.<category/> 
function CoreEWS.check_news(parent, category, new_only, style)
	local news = managers.news:check_news(category, not new_only, "TEXT")
	if news then
		if style == "RICH" then
			local dialog = EWS:Dialog(parent, "New Features!", "", Vector3(-1,-1,-1), Vector3(400, 450, 0), "")
			local box = EWS:BoxSizer("VERTICAL")
			box:add(EWS:TextCtrl(dialog, news, "", "TE_RICH2,TE_AUTO_URL,TE_MULTILINE,TE_READONLY,TE_DONTWRAP"), 1, 0, "EXPAND")
			
			local button = EWS:Button(dialog, "OK", "", "")
			button:connect("", "EVT_COMMAND_BUTTON_CLICKED", callback(dialog, dialog, "end_modal"), "")
			box:add(button, 0, 0, "ALIGN_RIGHT")
			
			dialog:set_sizer(box)
			dialog:show_modal()
		elseif style == "TIP" then
			EWS:tip_window(parent, news, CoreEWS.TIP_MAX_LEN)
		else -- "BOX"
			EWS:MessageDialog(parent, news, "New Features!", "OK,ICON_INFORMATION"):show_modal()
		end
	end
	return news
end

function CoreEWS.create_small_label( parent, text )
	local text = EWS:StaticText( parent, text, 0, "")
	text:set_font_size(7)
	return text
end

function CoreEWS.topdown_layout(w)
	local q = w
	while(q and q.type_name == "EWSPanel") do -- dirty, but dont know how to feed wanted level of recursion
		q:set_sizer_min_size()
		q:layout()
		q:refresh()
		q = q:parent()
	end
end

function CoreEWS.show_log(parent, text, caption)
	local dialog = EWS:Dialog(parent, caption or "Log", "", Vector3(-1,-1,0), Vector3(500.0, 500.0, 0.0), "CAPTION,SYSTEM_MENU,FRAME_FLOAT_ON_PARENT")
	local box = EWS:BoxSizer( "VERTICAL" )
	
	local text_ctrl = EWS:TextCtrl(dialog, "", "", "TE_MULTILINE,TE_READONLY")
	box:add(text_ctrl, 1, 0, "EXPAND")
	
	local ok_btn = EWS:Button(dialog, "OK", "", "")
	ok_btn:connect("", "EVT_COMMAND_BUTTON_CLICKED", callback(dialog, dialog, "end_modal"), "")
	box:add(ok_btn, 0, 4, "ALL,ALIGN_RIGHT")
	
	dialog:set_sizer(box)
	text_ctrl:set_value(text)
	dialog:show_modal()
end

function CoreEWS.show_log_file(parent, file, caption)
	local f = File:open(file, "r")
	if f then
		local str = f:read()
		if str ~= "" then
			CoreEWS.show_log(parent, str, caption or file)
		end
	end
end

--[[
CoreEWS.number_controller creates a text ctrlr that handles numbers.
The function takes a table paramas containing:
	name (optional)					- Used if a StaticText ctrlr should be added to before the TextCtrlr
	panel (required)				- The parent panel to the ctrlr(s)
	sizer(required)					- The sizer the ctrlr(s) should be added to (to function actually creates a new sizer for the ctrlrs
						  			  and then adds that sizer to the params.sizer
	value (optional)				- The default value of the ctrlr (will default to zero if not given
	name_proportions (optional)		- The proportions the name ctrlr should use when added (defaults to one)
	ctrlr_proportions (optional)	- The proportions the text ctrlr should use when added (defaults to one)
	floats (optional)				- Specifies how many floats it should allow (defaults to zero)
	tooltip (optional)				- A tooltip for the ctrlr
	max (optional)					- If specified, the entered value will be clamped to this if above
	min (optional)					- If specified, the entered value will be clamped to this if below
	events (optional)				- This should be a ipairs table containing tables with:
										event		-	The name of the event( "EVT_COMMAND_TEXT_ENTER" )
										callback	-	The function to be called.
									The function will recieve params as parameter. It contains all params used to
									create the ctrlrs as well as the created ctrlrs. It will also contain
									the last entered value, params.value.

The function returns the ctrlr, name ctrlr and params (which now also contains the ctrlrs)
]]
function CoreEWS.number_controller( params )
	params.value = params.value or 0
	params.name_proportions = params.name_proportions or 1
	params.ctrlr_proportions = params.ctrlr_proportions or 1
	params.floats = params.floats or 0
	
	params.ctrl_sizer = EWS:BoxSizer( "HORIZONTAL" )
	
	CoreEWS._ctrlr_tooltip( params )
	CoreEWS._name_ctrlr( params )
	CoreEWS._number_ctrlr( params )
			
	params.ctrl_sizer:add( params.number_ctrlr, params.ctrlr_proportions, 0, "EXPAND" )
	
	params.sizer:add( params.ctrl_sizer, 0, 0, "EXPAND" )
		
	CoreEWS._connect_events( params )
	return params.number_ctrlr, params.name_ctrlr, params
end

-- CoreEWS.verify_entered_number is used by CoreEWS.number_controller to verify the entered value and
-- match it to specified params.
function CoreEWS.verify_entered_number( params )
	local value = tonumber( params.number_ctrlr:get_value() ) or 0
	value = params.min and value < params.min and params.min or value
	value = params.max and value > params.max and params.max or value
	params.value = value
	local floats = params.floats or 0
	params.number_ctrlr:change_value( string.format( "%."..floats.."f", value ) )
	params.number_ctrlr:set_selection( -1, -1 )
end

-- This function can be called to set a number controller to a new value. First parameter should be the params
-- used to create the controller, and the second parameter is the new value.
function CoreEWS.change_entered_number( params, value )
	local floats = params.floats or 0
	params.value = value
	params.number_ctrlr:change_value( string.format( "%."..floats.."f", params.value ) )
end

function CoreEWS.change_slider_and_number_value( params, value )
	params.value = value
	params.slider_ctrlr:set_value( value * params.slider_multiplier )
	CoreEWS.change_entered_number( params, value )
end

-- Private function used to connect events from params
-- params.events				- This should be a ipairs table containing tables with:
--										event		-	The name of the event( "EVT_COMMAND_TEXT_ENTER" )
--										callback	-	The function to be called.
--								The callback function will recieve params as parameter. It contains all params used to
--								create the ctrlrs as well as the created ctrlrs. It will also contain
--								the last entered value, params.value.
function CoreEWS._connect_events( params )
	if not params.events then
		return
	end
	
	for _,data in ipairs( params.events ) do
		params.number_ctrlr:connect( data.event, data.callback, params )
	end
end

--[[
CoreEWS.combobox creates a combo box
The function takes a table paramas containing:
	name (optional)					- Used if a StaticText ctrlr should be added to before the ComboBox
	panel (required)				- The parent panel to the ctrlr(s)
	sizer(required)					- The sizer the ctrlr(s) should be added to (to function actually creates a new sizer for the ctrlrs
						  			  and then adds that sizer to the params.sizer
	default (optional)				- A default value to be appended first in the combo box (a "none" choice for example)
	options (required)				- A table containing all options to be appended to the combo box
	value (optional)				- The default value of the ctrlr (will default to first option if not given)
	name_proportions (optional)		- The proportions the name ctrlr should use when added (defaults to one)
	ctrlr_proportions (optional)	- The proportions the combo box ctrlr should use when added (defaults to one)
	tooltip (optional)				- A tooltip for the ctrlr
	styles (optional)				- Can be specified if a certain styles should be used (default is "CB_DROPDOWN,CB_READONLY")
	sorted (optional)				- If specified, the options table will be sorted before appended
The function returns the ctrlr, name ctrlr and params (which now also contains the ctrlrs)
]]
function CoreEWS.combobox( params )
	local name = params.name
	local panel = params.panel
	local sizer = params.sizer
	local default = params.default
	local options = params.options or {}
	local value = params.value or options[ 1 ]
	local name_proportions = params.name_proportions or 1
	local ctrlr_proportions = params.ctrlr_proportions or 1
	params.sizer_proportions = params.sizer_proportions or 0
	local tooltip = params.tooltip
	local styles = params.styles or "CB_DROPDOWN,CB_READONLY"
	local sorted = params.sorted
		
	local ctrl_sizer = EWS:BoxSizer( "HORIZONTAL" )

	local name_ctrlr
	if name then
		name_ctrlr = EWS:StaticText( panel, name, 0, "" )
		ctrl_sizer:add( name_ctrlr, name_proportions, 0, "ALIGN_CENTER_VERTICAL")
	end
		
	if sorted then
		table.sort( options )
	end
	
	local ctrlr = EWS:ComboBox( panel, "", "", styles )
	ctrlr:set_tool_tip( tooltip )
	
	ctrlr:freeze()
	
	if default then 
		ctrlr:append( default)
	end
	
	for _,option in ipairs( options ) do 
		ctrlr:append( option )
	end
	
	ctrlr:set_value( value )
	
	ctrlr:thaw()
	
	params.name_ctrlr = name_ctrlr
	params.ctrlr = ctrlr
		
	ctrl_sizer:add( ctrlr, ctrlr_proportions, 0, "EXPAND" )
	
	sizer:add( ctrl_sizer, params.sizer_proportions, 0, "EXPAND" )
	
	params.ctrlr:connect( "EVT_COMMAND_COMBOBOX_SELECTED", callback( nil, CoreEWS, "_set_combobox_value" ), params )
	
	CoreEWS._connect_events( params )
	return ctrlr, name_ctrlr, params
end

-- Private function to store the selected value made in a combobox
function CoreEWS._set_combobox_value( params )
	params.value = params.ctrlr:get_value()
end

-- Updates the availible options in a combobox. Call it with the params used to create it and a table
-- with the new options
function CoreEWS.update_combobox_options( params, options )
	params.ctrlr:clear()
	if params.sorted then
		table.sort( options )
	end
	if params.default then 
		params.ctrlr:append( params.default)
	end
	for _,option in ipairs( options ) do 
		params.ctrlr:append( option )
	end
end

-- This function changes the set value of the combobox. Call it with the params used to create it and the new value
function CoreEWS.change_combobox_value( params, value )
	params.value = value
	params.ctrlr:set_value( value )
end

--[[
CoreEWS.slider_and_number_controller creates a slider and text ctrlr to handle numbers. The slider and text ctrlr
is updated when the other is used.
The function takes a table paramas containing:
	name (optional)					- Used if a StaticText ctrlr should be added to before the TextCtrlr
	panel (required)				- The parent panel to the ctrlr(s)
	sizer(required)					- The sizer the ctrlr(s) should be added to (to function actually creates a new sizer for the ctrlrs
						  			  and then adds that sizer to the params.sizer
	value (optional)				- The default value of the ctrlr (will default to zero if not given
	name_proportions (optional)		- The proportions the name ctrlr should use when added (defaults to one)
	ctrlr_proportions (optional)	- The proportions the text ctrlr should use when added (defaults to one)
	floats (optional)				- Specifies how many floats it should allow (defaults to zero)
	tooltip (optional)				- A tooltip for the ctrlr
	max (optional)					- If specified, the entered value will be clamped to this if above
	min (optional)					- If specified, the entered value will be clamped to this if below
The function returns params (which now also contains the ctrlrs)
]]
function CoreEWS.slider_and_number_controller( params )
	params.value = params.value or 0
	params.name_proportions = params.name_proportions or 1
	params.ctrlr_proportions = params.ctrlr_proportions or 1
	params.slider_ctrlr_proportions = params.slider_ctrlr_proportions or 2
	params.number_ctrlr_proportions = params.number_ctrlr_proportions or 1
	params.floats = params.floats or 0
	params.slider_multiplier = math.pow( 10, params.floats )
	params.min = params.min or 0
	params.max = params.max or 10
	
	params.ctrl_sizer = EWS:BoxSizer( "HORIZONTAL" )
	
	CoreEWS._ctrlr_tooltip( params )
	CoreEWS._name_ctrlr( params )
	CoreEWS._number_ctrlr( params )
	CoreEWS._slider_ctrlr( params )
					
	params.number_ctrlr:connect( "EVT_COMMAND_TEXT_ENTER", callback( nil, CoreEWS, "update_slider_from_number" ), params )
	params.number_ctrlr:connect( "EVT_KILL_FOCUS", callback( nil, CoreEWS, "update_slider_from_number" ), params )
	
	params.slider_ctrlr:connect( "EVT_SCROLL_CHANGED", callback( nil, CoreEWS, "update_number_from_slider" ), params )
	params.slider_ctrlr:connect( "EVT_SCROLL_THUMBTRACK", callback( nil, CoreEWS, "update_number_from_slider" ), params )
	
	local ctrl_sizer2 = EWS:BoxSizer( "HORIZONTAL" )
		ctrl_sizer2:add( params.slider_ctrlr, params.slider_ctrlr_proportions, 0, "ALIGN_CENTER_VERTICAL" )
		ctrl_sizer2:add( params.number_ctrlr, params.number_ctrlr_proportions, 0, "EXPAND" )
	params.ctrl_sizer:add( ctrl_sizer2, params.ctrlr_proportions, 0, "EXPAND" )
	
	params.sizer:add( params.ctrl_sizer, 0, 0, "EXPAND" )
		
	-- CoreEWS._connect_events( params )
	return params
end

-- Private function to create the tooltip based on min and max values for sliders and number controllers
function CoreEWS._ctrlr_tooltip( params )
	local max = params.max
	local min = params.min
	if min and max then
		params.tooltip = (params.tooltip or "").." (Between "..string.format( "%."..params.floats.."f", min ).." and "..string.format( "%."..params.floats.."f", max )..")"
	elseif min then
		params.tooltip = (params.tooltip or "").." (Above "..string.format( "%."..params.floats.."f", min )..")"
	elseif max then
		params.tooltip = (params.tooltip or "").." (Below "..string.format( "%."..params.floats.."f", max )..")"
	end
end

-- Private function to create a slider controller and set tool tip
function CoreEWS._slider_ctrlr( params )
	params.slider_ctrlr = EWS:Slider( params.panel, params.value * params.slider_multiplier, params.min * params.slider_multiplier, params.max * params.slider_multiplier, "", "")
	params.slider_ctrlr:set_tool_tip( params.tooltip )
end

-- Private function to create a text controller for numbers and connect the events for verifying correct input
function CoreEWS._number_ctrlr( params )
	params.number_ctrlr = EWS:TextCtrl( params.panel, string.format( "%."..params.floats.."f", params.value ), "", "TE_PROCESS_ENTER" )
	params.number_ctrlr:set_tool_tip( params.tooltip )
	
	params.number_ctrlr:connect( "EVT_CHAR", callback( nil, _G, "verify_number" ), params.number_ctrlr )
	params.number_ctrlr:connect( "EVT_COMMAND_TEXT_ENTER", callback( nil, CoreEWS, "verify_entered_number" ), params )
	params.number_ctrlr:connect( "EVT_KILL_FOCUS", callback( nil, CoreEWS, "verify_entered_number" ), params )
end

-- Private function to create a name controller
function CoreEWS._name_ctrlr( params )
	if params.name then
		params.name_ctrlr = EWS:StaticText( params.panel, params.name, 0, "" )
		params.ctrl_sizer:add( params.name_ctrlr, params.name_proportions, 0, "ALIGN_CENTER_VERTICAL")
	end
end

-- CoreEWS.verify_entered_number is used by CoreEWS.number_controller to verify the entered value and
-- match it to specified params.
function CoreEWS.verify_entered_number( params )
	local ctrlr = params.ctrlr or params.number_ctrlr
	local value = tonumber( ctrlr:get_value() ) or 0
	value = params.min and value < params.min and params.min or value
	value = params.max and value > params.max and params.max or value
	params.value = value
	local floats = params.floats or 0
	ctrlr:change_value( string.format( "%."..floats.."f", value ) )
	ctrlr:set_selection( -1, -1 )
end

function CoreEWS.update_slider_from_number( params )
	params.slider_ctrlr:set_value( params.value * params.slider_multiplier )
end

function CoreEWS.update_number_from_slider( params )
	params.value = params.slider_ctrlr:get_value() / params.slider_multiplier
	CoreEWS.change_entered_number( params, params.value )
end

-- Map custom widgets.
function CoreEWS:CollapseBox(...)
	return core_or_local("CoreCollapseBox", self:_remove_self(...))
end

function CoreEWS:XMLTextCtrl(...)
	return core_or_local("XMLTextCtrl", self:_remove_self(...))
end

function CoreEWS:_remove_self(...)
	local params = {...}
	if #params > 0 and params[1] == CoreEWS then
		params = {select(2, ...)}
	end
	return unpack(params)
end
