///@category Menu Input System
///@param {int} controllers		The max number of controllers that can be connected
///@param {int} keyboards		The max number of keyboards that can be connected
///@param {int} custom			The max number of custom devices that can be connected
///@param {int} total			The max number of all devices that can be connected
/*
Sets the limits for number of connected controllers, keyboards, custom devices, and the total devices that can be connected to the Menu Input System.
*/
function mis_device_limit_set() {
	var _c = argument[0];
	var _k = argument[1];
	var _u = argument[2];
	var _t = argument[3];
	mis_data().max_controllers = _c;
	mis_data().max_keyboards = _k;
	mis_data().max_custom = _u;
	mis_data().max_total = _t;
	return;
}
/* Copyright 2023 Springroll Games / Yosi */