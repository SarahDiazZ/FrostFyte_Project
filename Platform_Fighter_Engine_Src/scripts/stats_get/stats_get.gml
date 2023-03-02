///@category Startup
///@param {string} stat_name		The name of the stat to update
/*
Returns the value of the specified stat. If the stat does not exist, undefined will be returned.
*/
function stats_get() {
	var _name = argument[0];
	var _struct = engine().stats;
	if (!variable_struct_exists(_struct, _name))
		{
		return undefined;
		}
	return _struct[$ _name];
}
/* Copyright 2023 Springroll Games / Yosi */