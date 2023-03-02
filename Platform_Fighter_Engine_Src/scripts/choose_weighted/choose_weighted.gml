///@param {array} [value,weight...]			Any number of pairs of values and integer "weights"
/*
Randomly chooses a value from an array of consecutive value/weight pairs.
Values with higher weight integers will be chosen more often than values with lower weight integers.
*/
function choose_weighted() {
	var _array = argument[0];
	var _len = array_length(_array);
	assert(_len % 2 == 0, "[choose_weighted] Array length must be even! (", _len, ")");
	var _weight = 0;
	for(var i = 1; i < _len; i += 2) 
		{
		_weight += _array[i];
		}
	var _random = irandom(_weight);
	_weight = 0;
	for(var i = 1; i < _len; i += 2) 
		{
		_weight += _array[i];
		if (_weight >= _random) 
			{
			return _array[i - 1];
			}
		}
	return _array[0];
}
/* Copyright 2023 Springroll Games / Yosi */