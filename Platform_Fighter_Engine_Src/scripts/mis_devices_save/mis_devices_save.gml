///@category Menu Input System
/*
Returns a json string of all the current Menu Input System device data (except inputs).
This string can be used to later load in the devices via <mis_devices_load>.
*/
function mis_devices_save() {
	var _array = [];
	for(var i = 0; i < array_length(mis_data().devices); i++) 
		{
		array_push(_array, mis_data().devices[@ i]);
		}
	return json_stringify(_array);
}
/* Copyright 2023 Springroll Games / Yosi */