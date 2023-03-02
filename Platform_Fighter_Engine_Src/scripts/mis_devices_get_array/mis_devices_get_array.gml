///@category Menu Input System
/*
Returns an array that has the device id number of every device currently in the Menu Input System.
*/
function mis_devices_get_array() {
	var _array = mis_data().devices;
	var _size = array_length(_array);
	var _new = array_create(_size, undefined);
	for(var i = 0; i < _size; i++) 
		{
		_new[@ i] = _array[@ i][@ MIS_DEVICE_PROPERTY.device_id];
		}
	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */