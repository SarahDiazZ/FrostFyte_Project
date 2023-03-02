///@category Menu Input System
///@param {int} port_number		The device port to check
///@param {int} device_type		The device type to check for, from the MIS_DEVICE_TYPE enum
/*
Checks if there is a connected device with the given port_number and type in the Menu Input System.
*/
function mis_device_port_is_connected() {
	var _port = argument[0];
	var _type = argument[1];
	//Find the device with the given port number and type
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.port_number] == _port &&
			_array[@ i][@ MIS_DEVICE_PROPERTY.device_type] == _type) 
			{
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */