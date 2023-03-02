///@category Custom Controls
///@param {int} advanced_controller_setting			The ACS to get the name of
///@param {any} current_value						The current_value of the ACS
/*
Returns a formatted string of the value of the given ACS.
*/
function acs_value_string() {
	var _acs = argument[0];
	var _val = argument[1];
	switch(_acs)
		{
		case ACS.deadzone_l:
		case ACS.deadzone_r:
		case ACS.maximum_l:
		case ACS.maximum_r:
		case ACS.speed_l:
		case ACS.speed_r:
			return string(round(_val * 100)) + "%";
		case ACS.invert_x_l:
		case ACS.invert_x_r:
		case ACS.invert_y_l:
		case ACS.invert_y_r:
		case ACS.rotate_l:
		case ACS.rotate_r:
			return _val ? "ON" : "OFF";
		default: crash("[acs_value_string] Invalid ACS number (", _acs, ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */