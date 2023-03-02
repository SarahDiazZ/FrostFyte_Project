///@param {int} channel						The PRNG channel to use
///@param {any} values						Any number of values to choose from
/*
Returns one of the given values pseudo-randomly.
*/
function prng_choose() {
	var _channel = (argument[0] % prng_channels);
	var _random = prng_number(_channel, argument_count - 1, 1);
	return argument[_random];
}
/* Copyright 2023 Springroll Games / Yosi */