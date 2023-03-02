///@category Menu Input System
///@param {int} device_type		The device type, from the MIS_DEVICE_TYPE enum
///@param {int} port_number		The port number
///@param {any} [custom]		Any custom data
/*
Connects the device on the given port number to the Menu Input System, even if no input has been made.
*/
function mis_device_connect() {
	var _type = argument[0];
	var _port = argument[1];
	var _custom = argument_count > 2 ? argument[2] : undefined;
	var _array = mis_data().devices;
	
	//Check the max number of connected devices for the specific type
	var _current_number = 0;
	var _max_number = 0;
	if (_type == MIS_DEVICE_TYPE.controller) then _max_number = mis_data().max_controllers;
	else if (_type == MIS_DEVICE_TYPE.keyboard) then _max_number = mis_data().max_keyboards;
	else if (_type == MIS_DEVICE_TYPE.custom) then _max_number = mis_data().max_custom;
	else crash("[mis_device_connect] Invalid MIS device type (", _type, ")");
	for(var i = 0; i < array_length(_array); i++)
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_type] == _type)
			{
			_current_number++;
			}
		}
	if (_current_number < _max_number)
		{
		//Check that the device isn't already connected
		if (!mis_device_port_is_connected(_port, _type) && array_length(_array) < mis_data().max_total) 
			{
			var _new = [];
			_new[@ MIS_DEVICE_PROPERTY.device_type] = _type;
			_new[@ MIS_DEVICE_PROPERTY.port_number] = _port;
			_new[@ MIS_DEVICE_PROPERTY.inputs] = array_create(MIS_INPUT.LENGTH * 2, 0);
			_new[@ MIS_DEVICE_PROPERTY.stick_values] = { x : 0, y : 0, press : false, hold : 0 };
			_new[@ MIS_DEVICE_PROPERTY.device_id] = mis_data().device_id_current;
			_new[@ MIS_DEVICE_PROPERTY.custom] = _custom;
			mis_data().device_id_current += 1;
			array_push(_array, _new);
			
			//Connect callback
			if (!is_undefined(mis_data().connect_callback)) 
				{
				mis_data().connect_callback(_new[@ MIS_DEVICE_PROPERTY.device_id]);
				}
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */