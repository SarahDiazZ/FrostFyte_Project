///@category Menu Input System
///@param {int} device_id		The id of the device
///@param {int} input			The input to check, from the MIS_INPUT enum
///@param {bool} [hold]			Whether to check for how long the input has been held
/*
Returns whether the input is pressed or not for a device in the Menu Input System. 
If "hold" is true, it returns the number of frames the input has been held down.
*/
function mis_device_input() {
	var _id = argument[0];
	var _input = argument[1];
	var _hold = argument_count > 2 ? argument[2] : false;
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			if (_hold) 
				{
				return _array[@ i][@ MIS_DEVICE_PROPERTY.inputs][@ _input + MIS_INPUT.LENGTH];
				} 
			else 
				{
				return _array[@ i][@ MIS_DEVICE_PROPERTY.inputs][@ _input];
				}
			}
		}
	crash("[mis_device_input] No device exists with the given ID (", _id, ")");
}
/* Copyright 2023 Springroll Games / Yosi */