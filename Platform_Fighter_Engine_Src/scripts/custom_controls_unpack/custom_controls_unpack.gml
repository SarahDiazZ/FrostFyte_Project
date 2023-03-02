///@category Custom Controls
///@param {struct} custom_controls		The custom controls struct
///@param {int} device_type				The device type to get the controls for, from the DEVICE enum
/*
Returns an array with the data from a custom controls struct to be used by players.
The format is: [button/key, input, button/key, input, ...]
*/
function custom_controls_unpack() {
	var _struct = argument[0];
	var _device_type = argument[1];
	
	var _array;
	if (_device_type == DEVICE.controller) then _array = _struct.inputs_controller;
	else if (_device_type == DEVICE.keyboard) then _array = _struct.inputs_keyboard;
	else if (_device_type == DEVICE.touch) then _array = _struct.inputs_touch;
	else if (_device_type == DEVICE.none) then _array = [];
	else crash("[custom_controls_unpack] Invalid device type (", _device_type, ")");

	var _unpacked = [];

	//For each input
	for(var i = 0; i < array_length(_array); i++)
		{
		var _inner_array = _array[@ i];
		//For each possible button/key
		for(var m = 0; m < array_length(_inner_array); m++)
			{
			array_push(_unpacked, _inner_array[@ m]);
			array_push(_unpacked, i);
			}
		}
	
	log("Custom controls unpacked: ", _unpacked);
	
	return _unpacked;
}
/* Copyright 2023 Springroll Games / Yosi */