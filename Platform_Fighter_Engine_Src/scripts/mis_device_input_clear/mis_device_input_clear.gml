///@category Menu Input System
///@param {int} device_id		The id of the device
/*
Clears all of the input for the given device.
*/
function mis_device_input_clear() {
	var _id = argument[0];
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			_array[@ i][@ MIS_DEVICE_PROPERTY.inputs] = array_create(MIS_INPUT.LENGTH * 2, 0);
			return;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */