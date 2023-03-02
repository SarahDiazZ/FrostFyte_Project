///@category Custom Controls
///@param {int} advanced_controller_setting			The ACS to get the name of
///@param {any} current_value						The current value of the ACS
/*
Returns the next possible value of the given ACS based on the current value.
*/
function acs_change() {
	var _acs = argument[0];
	var _val = argument[1];
	switch(_acs)
		{
		case ACS.deadzone_l:
			_val += 0.1;
			if (_val > 0.9)
				_val = 0.0;
			else if (_val < 0.0)
				_val = 0.0;
			return _val;
		case ACS.deadzone_r:
			_val += 0.1;
			if (_val > 0.9)
				_val = 0.0;
			else if (_val < 0.0)
				_val = 0.0;
			return _val;
		case ACS.invert_x_l:
			return !_val;
		case ACS.invert_x_r:
			return !_val;
		case ACS.invert_y_l:
			return !_val;
		case ACS.invert_y_r:
			return !_val;
		case ACS.maximum_l:
			_val += 0.1;
			if (_val > 1.0)
				_val = 0.1;
			else if (_val < 0.1)
				_val = 0.1;
			return _val;
		case ACS.maximum_r:
			_val += 0.1;
			if (_val > 1.0)
				_val = 0.1;
			else if (_val < 0.1)
				_val = 0.1;
			return _val;
		case ACS.rotate_l:
			return !_val;
		case ACS.rotate_r:
			return !_val;
		case ACS.speed_l:
			_val += 0.1;
			if (_val > 2.0)
				_val = 0.0;
			else if (_val < 0.1)
				_val = 0.1;
			return _val;
		case ACS.speed_r:
			_val += 0.1;
			if (_val > 2.0)
				_val = 0.0;
			else if (_val < 0.1)
				_val = 0.1;
			return _val;
		default: crash("[acs_change] Invalid ACS number (", _acs, ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */