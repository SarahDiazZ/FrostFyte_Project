///@category Menu Input System
///@param {int} device_type		The device type to convert, from the MIS_DEVICE_TYPE enum
///@param {bool} [reverse]		If the function should take from the DEVICE enum instead
/*
Converts a device type from the MIS_DEVICE_TYPE enum to the closest entry in the DEVICE enum.
If the "reverse" argument is true, the function converts from DEVICE to MIS_DEVICE_TYPE instead.
*/
function mis_device_convert_to_game_device() {
	var _device_type = argument[0];
	var _reverse = argument_count > 1 ? argument[1] : false;
	if (_reverse)
		{
		if (_device_type == DEVICE.controller) then return MIS_DEVICE_TYPE.controller;
		if (_device_type == DEVICE.keyboard) then return MIS_DEVICE_TYPE.keyboard;
		if (_device_type == DEVICE.none) then return MIS_DEVICE_TYPE.none;
		if (_device_type == DEVICE.touch) then return MIS_DEVICE_TYPE.custom;
		}
	else
		{
		if (_device_type == MIS_DEVICE_TYPE.controller) then return DEVICE.controller;
		if (_device_type == MIS_DEVICE_TYPE.keyboard) then return DEVICE.keyboard;
		if (_device_type == MIS_DEVICE_TYPE.none) then return DEVICE.none;
		if (_device_type == MIS_DEVICE_TYPE.custom) then return DEVICE.touch;
		}
}
/* Copyright 2023 Springroll Games / Yosi */