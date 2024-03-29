core:module( "CoreMissionScriptElement" )
core:import( "CoreXml" )
core:import( "CoreCode" )
core:import( "CoreClass" )

MissionScriptElement = MissionScriptElement or class()

function MissionScriptElement:init( mission_script, data )
	self._mission_script 	= mission_script
	-- self._values_extensions = {}
	self._id 				= data.id
	self._editor_name 		= data.editor_name
	self._values 			= data.values
end

-- Called when all mission element has been set up. Here it is possible to access
-- other mission elements if needed
function MissionScriptElement:on_created()
end

-- Called when the script this element belongs to is activated. Generally this is where trigger elements
-- should beging being triggerable. (Areas shouldn't be active until this for example)
function MissionScriptElement:on_script_activated()
end

-- Returns an element from the mission script
function MissionScriptElement:get_mission_element( id )
	return self._mission_script:element( id )
end

-- Returns the name used in the editor
function MissionScriptElement:editor_name()
	return self._editor_name
end

-- Returns the values table
function MissionScriptElement:values()
	return self._values
end

-- Returns a value
function MissionScriptElement:value( name )
	return self._values[ name ]
end

-- Returns enabled value
function MissionScriptElement:enabled()
	return self._values.enabled
end

-- Check if the intigator is valid
function MissionScriptElement:_check_instigator( instigator )
	if CoreClass.type_name( instigator ) == "Unit" then
		return instigator
	end
	return managers.player:player_unit() -- can be nil
end

function MissionScriptElement:on_executed( instigator )
	if not self._values.enabled then
		return
	end
	
	instigator = self:_check_instigator( instigator )
	
	if Network:is_server() then -- Server sends to clients that something should be executed
		-- Send different messages depending if there is an instigator or not
		if instigator and alive( instigator ) and instigator:id() ~= -1 then
			managers.network:session():send_to_peers_synched( "run_mission_element", self._id, instigator )
		else
			managers.network:session():send_to_peers_synched( "run_mission_element_no_instigator", self._id )
		end
	end
	
	self:_print_debug_on_executed( instigator )
	self:_reduce_trigger_times()

	if self._values.base_delay > 0 then
		self._mission_script:add( callback( self, self, "execute_on_executed", instigator ), self._values.base_delay, 1 )
	else
		self:execute_on_executed( instigator )
	end
end

function MissionScriptElement:_print_debug_on_executed( instigator )
	if self:is_debug() then
		self:_print_debug( "Element '" .. self._editor_name .. "' executed.", instigator )
		-- self._mission_script:debug_output( "".."Object '" .. self._editor_name .. "' executed." )
		if instigator then
			--[[
			local data = instigator:data()
			if data._spawner and data._spawner:editor_name() then
				("", "Instigator: '" .. data._spawner:editor_name() .. "' (" .. data._spawner_id .. ") '".. instigator:name() .. "'")
			else
				("", "Instigator: '" .. instigator:name() .. "'")
			end
			]]
		end
	end
end

function MissionScriptElement:_print_debug( debug, instigator )
	if self:is_debug() then
		self._mission_script:debug_output( debug )
	end
end

function MissionScriptElement:_reduce_trigger_times()
	if self._values.trigger_times > 0 then
		self._values.trigger_times = self._values.trigger_times - 1
		if self._values.trigger_times <= 0 then
			self._values.enabled = false
		end
	end
end

function MissionScriptElement:execute_on_executed( instigator )
	for _,params in ipairs( self._values.on_executed ) do
		local element = self:get_mission_element( params.id )
		if element then
			if params.delay > 0 then
				if self:is_debug() or element:is_debug() then
					self._mission_script:debug_output( "  Executing element '" .. element:editor_name() .. "' in "..params.delay.." seconds ...", Color( 1, 0.75, 0.75, 0.75 ) )
				end
				self._mission_script:add( callback( element, element, "on_executed", instigator ), params.delay, 1 )
			else
				if self:is_debug() or element:is_debug() then
					self._mission_script:debug_output( "  Executing element '" .. element:editor_name() .. "' ...", Color( 1, 0.75, 0.75, 0.75 ) )
				end
				element:on_executed( instigator )
			end
		end
	end
end

function MissionScriptElement:on_execute_element( element, instigator )
	element:on_executed( instigator )
end

-- Called from toggle element
function MissionScriptElement:set_enabled( enabled )
	self._values.enabled = enabled
end

-- Called when a toogle has occured
function MissionScriptElement:on_toggle( value )
end

-- Can be called from toggle element
function MissionScriptElement:set_trigger_times( trigger_times )
	self._values.trigger_times = trigger_times
end

-- Check if this element is in debug or if entire script is in debug
function MissionScriptElement:is_debug()
	return self._values.debug or self._mission_script:is_debug()
end

-- Called when a simulation is stopped
function MissionScriptElement:stop_simulation( ... )
end

-- Called from element CoreElementOperator (logic_operator)
function MissionScriptElement:operation_add()	
	if Application:editor() then
		managers.editor:output_error( "Element "..self:editor_name().." doesn't have an 'add' operator implemented." )
	end
end

-- Called from element CoreElementOperator (logic_operator)
function MissionScriptElement:operation_remove()	
	if Application:editor() then
		managers.editor:output_error( "Element "..self:editor_name().." doesn't have a 'remove' operator implemented." )
	end
end

-- Called from element ElementApplyJobValue (func_apply_job_value)
function MissionScriptElement:apply_job_value()
	if Application:editor() then
		managers.editor:output_error( "Element "..self:editor_name().." doesn't have a 'apply_job_value' function implemented." )
	end
end

-- Called when leaving game
function MissionScriptElement:pre_destroy()
end

-- Called when leaving game
function MissionScriptElement:destroy()
end

--[[
function ScriptElement:set_unitdata_params( unit, values, extensions )
	for i, v in pairs( values ) do
		local var = v
		if type(v) == "string" then
			var = string_to_value( type( unit:data()[ i ] ), v )
		end
		if extensions and extensions[ i ] then
			local ext = unit:extensions_infos()[ extensions[ i ] ]
			ext[ i ] = var
			if ext.on_properties_loaded then
				ext:on_properties_loaded( unit )
			end
		else
			unit:data()[ i ] = var
		end
	end

	managers.aimessage:send("variables_modified", unit, "move", nil )
end

function ScriptElement:show_unit_debug_info( unit )
	if unit then
		local data = unit:data()
		if data and data._spawner and data._spawner._editor_name then
			("[ScriptManager]SCRIPT DEBUG:", " - Unit: '" .. data._spawner._editor_name .. "' (" .. data._spawner_id .. ") '" .. unit:name() .. "'")
		else
			("[ScriptManager]SCRIPT DEBUG:", " - Unit: '" .. unit:name() .. "'")
		end
	end
end

function ScriptElement:on_toggle( enable )
end

function ScriptElement:get_id_table( ids )
	if not ids or #ids == 0 then
		return {}
	end

	local id_table = {}
	for _, id in pairs( ids ) do
		table.insert(id_table, id)
	end
	return id_table
end

function ScriptElement:get_units_by_id( ids )
	local id_table = self:get_id_table( ids )
	if #id_table == 0 then
		return {}
	end

	local list = {}
	local units = World:unit_manager():get_units( managers.slot:get_mask( "all" ) )
	for _, unit in pairs(units) do
		if unit and alive( unit ) and unit:unit_data() and table.contains(id_table, unit:unit_data().unit_id) then
			table.insert(list, unit)
		end
	end
	return list
end

function ScriptElement:get_units_by_type( types )
	if not types or #types == 0 then
		return {}
	end

	local unit_table = self:get_units_by_id( types )
	local type_table = {}

	for _,unit in pairs(unit_table) do
		table.insert(type_table, unit:name())
	end

	local list = {}
	local units = World:unit_manager():get_units( managers.slot:get_mask( "all" ) )
	for _, unit in pairs(units) do
		if unit and alive( unit ) and table.contains(type_table, unit:name()) then
			table.insert(list, unit)
		end
	end
	return list
end
]]
