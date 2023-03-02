///@category Menu Input System
///@param {int} device_id		The id of the device
///@param {int} input			The input to delete, from the MIS_INPUT enum
/*
Changes the given input so it is no longer counted as being pressed or held for the specified device.
*/
function mis_device_input_delete() {
	var _id = argument[0];
	var _input = argument[1];
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		var _device = _array[@ i];
		if (_device[@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			_device[@ MIS_DEVICE_PROPERTY.inputs][@ _input] = false;
			_device[@ MIS_DEVICE_PROPERTY.inputs][@ _input + MIS_INPUT.LENGTH] = false;
			return true;
			}
		}
	crash("[mis_device_input_delete] No device exists with the given ID (", _id, ")");
}
/* Copyright 2023 Springroll Games / Yosi */