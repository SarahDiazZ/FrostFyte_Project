///@category Menu Input System
///@param {int} device_id		The id of the device to disconnect
/*
Disconnects the given device from the Menu Input System.
Note: This will not change the device ids of other devices.
*/
function mis_device_disconnect() {
	var _id = argument[0];
	//Find the device with the given id number
	var _array = mis_data().devices;
	for(var i = 0; i < array_length(_array); i++) 
		{
		if (_array[@ i][@ MIS_DEVICE_PROPERTY.device_id] == _id) 
			{
			array_delete(_array, i, 1);
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */