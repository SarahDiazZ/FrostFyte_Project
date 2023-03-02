///@param {int} channel			The channel to get a number from
///@param {int} max				The maximum number that can be returned
///@param {int} [min]			The minimum number that can be returned
/*
Returns the pseudo-randomly generated integer stored in the given channel for the current frame. This is intended for use in anything that affects the game state, as it is deterministic, and only works if <obj_game> is present.
The number of available channels is set from the macro <prng_channels>.
The maximum range (the greatest possible difference between the max and min) is set from the macro <prng_range>.
The default minimum number that can be returned is 0.
Warning: Depending on the macros, the numbers generated could fall into a short pattern. Look up "linear congruential generators" for more info ;)
*/
function prng_number() {
	assert(instance_number(obj_game) > 0, "obj_game did not exist when prng_number was called");
	var _channel = (argument[0] % prng_channels);
	var _max = argument[1];
	var _min = argument_count > 2 ? argument[2] : 0;
	var _difference = (_max - _min) + 1;
	
	assert(_max >= _min, "[prng_number] The max value (", _max, ") is not greater than or equal to the min value (", _min, ")");
	
	var _num = clamp(floor((((obj_game.prng_numbers[@ _channel]) / prng_range) * _difference) + 0.5) + _min, _min, _max);
	return _num;
}
/* Copyright 2023 Springroll Games / Yosi */