///@category Debugging
///@param {string} key          The key of the value to find in the struct
///@param {any} [default]       The value to return if the key does not exist
///@param {bool} [any_type]		If the value should be read as whatever data type GameMaker detects, instead of always converting to a real number
/*
Finds and returns a specific property from the live values struct, which is generated when <live_values_reload> is called.
If the value cannot be found in the struct, the function will return undefined unless a default return value is specified.
If the "any_type" argument is true, the value will be read as whatever data type GameMaker detects; otherwise, the value will be converted to a real number.
Please note: When debug mode is turned on, you can press F11 to reload the live values.
Warning: This is intended for debug use only.
*/
function live_value() {
    var _key = argument[0];
    var _default = argument_count > 1 ? argument[1] : undefined;
	var _any_type = argument_count > 2 ? argument[2] : false;
    var _struct = live_values_stored_data().struct;
    if (is_struct(_struct))
        {
        if (variable_struct_exists(_struct, _key))
            {
			var _val = _struct[$ _key];
			return (_any_type ? _val : real(_val));
            }
        }
    return _default;
}
/* Copyright 2023 Springroll Games / Yosi */