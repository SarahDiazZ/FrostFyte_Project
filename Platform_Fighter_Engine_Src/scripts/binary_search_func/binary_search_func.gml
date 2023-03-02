///@param {array} array				The sorted array to search
///@param {int/real} value			The value to find
///@param {function} function		The comparison function to use
///@param {int} [start]				The lower bound
///@param {int} [end]				The upper bound
/*
Returns the index in the array sorted from least to greatest where the function returns true. 
If the function does not return true for any value in the array, -1 is returned.

The function should take the following arguments:
	- middle_value : The value in the array being checked
	- value : The value to compare to
and should return -1 if the middle value is less than the value, 1 if the middle value is greater than the value, and 0 if the values are equal.
*/
function binary_search_func() {
	var _a = argument[0];
	var _v = argument[1];
	var _f = argument[2];
	var _start = argument_count > 3 ? argument[3] : 0;
	var _end = argument_count > 4 ? argument[4] : array_length(_a);
	
	//Return -1 if the value was not found
	if (_start > _end) then return -1;
	
	//Middle index
	var _mid = floor((_start + _end) / 2);
	var _mid_v = _a[@ _mid];
	var _result = _f(_mid_v, _v);
	if (_result == 0) then return _mid;
	
	//If the element at the middle is greater than the value, search on the left side
	if (_result > 0) {
		return binary_search_func(_a, _v, _f, _start, _mid - 1);
	} else {
		//Otherwise, search on the right side
		return binary_search_func(_a, _v, _f, _mid + 1, _end);
	}
}

/* Copyright 2023 Springroll Games / Yosi */