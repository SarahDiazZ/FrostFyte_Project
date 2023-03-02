///@param {real} x		The initial value
///@param {real} m		The maximum value
/*
Wraps a value around the range of 0 to the maximum value.
*/
function modulo() {
	return (argument[0] % argument[1] + argument[1]) % argument[1];
}
/* Copyright 2023 Springroll Games / Yosi */