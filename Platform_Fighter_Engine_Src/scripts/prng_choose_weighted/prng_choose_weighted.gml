///@param {int} channel						The PRNG channel to use
///@param {array} [value,weight...]			Any number of pairs of values and integer "weights"
/*
Pseudo-randomly chooses a value from an array of consecutive value/weight pairs.
Values with higher weight integers will be chosen more often than values with lower weight integers.

Please note: The weight value is NOT a percentage.
For example, in the following code, both function calls would have the same 50% chance of returning true or false, since the values have the same weight:
	prng_choose_weighted(0, [true, 50, false, 50]);
	prng_choose_weighted(0, [true, 173, false, 173]);
	
Warning: The combined weight values cannot be greater than the <prng_range>.
*/
function prng_choose_weighted() {
	var _channel = (argument[0] % prng_channels);
	var _array = argument[1];
	var _len = array_length(_array);
	assert(_len % 2 == 0, "[prng_choose_weighted] Array length must be even! (", _len, ")");
	var _weight = 0;
	for(var i = 1; i < _len; i += 2) 
		{
		_weight += _array[@ i];
		}
	var _random = prng_number(_channel, _weight);
	_weight = 0;
	for(var i = 1; i < _len; i += 2) 
		{
		_weight += _array[@i];
		if (_weight >= _random) 
			{
			return _array[@ i - 1];
			}
		}
	return _array[@ 0];
}
/* Copyright 2023 Springroll Games / Yosi */