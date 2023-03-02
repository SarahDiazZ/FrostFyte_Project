///@param {array} array			The sorted array to search
///@param {int/real} value		The value to find
///@param {int} [start]			The lower bound
///@param {int} [end]			The upper bound
/*
Returns the index of the given value in the array sorted from least to greatest. 
If the value does not exist in the array, -1 is returned.
*/
function binary_search() {
	var _a = argument[0];
	var _v = argument[1];
	var _start = argument_count > 2 ? argument[2] : 0;
	var _end = argument_count > 3 ? argument[3] : array_length(_a);
	
	//Return -1 if the value was not found
	if (_start > _end) then return -1;
	
	//Middle index
	var _mid = floor((_start + _end) / 2);
	var _mid_v = _a[@ _mid];
	if (_mid_v == _v) then return _mid;
	
	//If the element at the middle is greater than the value, search on the left side
	if (_mid_v > _v) {
		return binary_search(_a, _v, _start, _mid - 1);
	} else {
		//Otherwise, search on the right side
		return binary_search(_a, _v, _mid + 1, _end);
	}
}

/* Copyright 2023 Springroll Games / Yosi */