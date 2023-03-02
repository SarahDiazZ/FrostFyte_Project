///@category Menu Input System
///@param {function} callback		The callback function
/*
Set a callback script or function to be called whenever a new device is connected to the Menu Input System.
The function should have the format: callback([device_id]), where the device_id argument is the id number of the device in the Menu Input System.
*/
function mis_device_connect_callback_set() {
	if (is_method(argument[0]) || script_exists(argument[0])) 
		{
		mis_data().connect_callback = argument[0];
		} 
	else
		{
		crash("[mis_device_connect_callback_set] Argument is not a valid script or method! (", argument[0], ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */