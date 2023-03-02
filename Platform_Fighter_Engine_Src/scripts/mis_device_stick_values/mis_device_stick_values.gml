///@category Menu Input System
///@param {int} device_id		The id of the device
/*
Returns a struct with stick values for the given device in the Menu Input System.
The struct has the following properties:
	- x : The value of the stick on the x axis, from -1 (left) to 1 (right).
	- y : The value of the stick on the y axis, from -1 (up) to 1 (down).
	- press : Whether the stick has been pressed in a direction or not.
	- hold : How many frames the stick has been held in a direction.
*/
///@desc Returns a struct with X/Y values, in addition to the press/hold variables.
function mis_device_stick_values() {
	var _id = argument[0];
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			return _array[@ i][@ MIS_DEVICE_PROPERTY.stick_values];
			}
		}
	crash("[mis_device_stick_values] No device exists with the given ID (", _id, ")");
}
/* Copyright 2023 Springroll Games / Yosi */