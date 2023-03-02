///@category Menu Input System
///@param {int} device_id		The id of the device
/*
Checks if there is a connected device with the given id in the Menu Input System.
*/
function mis_device_is_connected() {
	var _id = argument[0];
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */