///@category Startup
///@param {string} stat_name		The name of the stat to update
///@param {any} value				The new value
///@param {bool} [relative]			Whether the new value should be added to the existing value or not
/*
This function can update the value of any global game stat.
If the stat does not exist, it will be added to the engine().<stats> struct.
The current value of the stat is returned.
*/
function stats_set() {
	var _name = argument[0];
	var _value = argument[1];
	var _relative = argument_count > 2 ? argument[2] : false;
	var _struct = engine().stats;
	if (!variable_struct_exists(_struct, _name))
		{
		_struct[$ _name] = _value;
		}
	else
		{
		if (_relative)
			{
			_struct[$ _name] += _value;
			}
		else
			{
			_struct[$ _name] = _value;
			}
		}
	log("Stat \"", _name, "\" has been updated to ", _value);
	return _struct[$ _name];
}
/* Copyright 2023 Springroll Games / Yosi */