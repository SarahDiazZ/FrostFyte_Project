///@category Menu Input System
///@param {int} device_id		The id of the device
///@param {int} property		The property to get, from the MIS_DEVICE_PROPERTY enum
///@param {any} value			The value
/*
Gets the property of the given device from the Menu Input System to the given value.
*/
function mis_device_set() {
	var _id = argument[0];
	var _property = argument[1];
	var _value = argument[2];
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			_array[@ i][@ _property] = _value;
			return;
			}
		}
	crash("[mis_device_input_set] No device exists with the given ID (", _id, ")");
}
/* Copyright 2023 Springroll Games / Yosi */