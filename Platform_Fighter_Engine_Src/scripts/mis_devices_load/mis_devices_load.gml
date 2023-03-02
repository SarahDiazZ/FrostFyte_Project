///@category Menu Input System
///@param {string} json						The string with previously saved MIS device data in it
///@param {bool} [run_connect_callback]		Whether to run the connect callback function for devices stored in the json string or not
/*
Disconnects all Menu Input System devices, and then reconnects devices based on the data stored in the json string generated from <mis_devices_save>.
If "run_connect_callback" is true, the previously set connect callback will be run for each device that was stored in the json string.
*/
///@desc Loads the json string of device data, replacing all current device data. It also ensures that the device ID will not overlap.
function mis_devices_load() {
	var _array = json_parse(argument[0]);
	var _run_callback = argument_count > 1 ? argument[1] : false;
	var _max_id = mis_data().device_id_current;
	mis_device_disconnect_all();
	for(var i = 0; i < array_length(_array); i++) 
		{
		array_push(mis_data().devices, _array[@ i]);
		_max_id = max(_max_id, (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] + 1));
		//Connect callback
		if (_run_callback && !is_undefined(mis_data().connect_callback)) 
			{
			mis_data().connect_callback(_array[@ i][@ MIS_DEVICE_PROPERTY.device_id]);
			}
		}
	mis_data().device_id_current = _max_id;
	return;
}
/* Copyright 2023 Springroll Games / Yosi */