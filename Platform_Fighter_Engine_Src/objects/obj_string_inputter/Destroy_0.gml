///@description Reset the MIS inputs
var _array = mis_devices_get_array();
for(var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i]; 
	mis_device_input_clear(_id);
	}
/* Copyright 2023 Springroll Games / Yosi */