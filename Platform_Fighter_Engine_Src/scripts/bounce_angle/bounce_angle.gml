///@category Collisions
///@param {real} initial		The angle the object is moving before hitting the slope
///@param {real} slope			The angle of the slope
/*
Calculates the angle an object would be moving at after bouncing off a slope.
Please note: As of version 1.3.0, this is only used in <check_tech> if the slope instance's "slope_type" is set to "SLOPE_TYPE.calculated_bounce".
*/
function bounce_angle() {
	var _i = modulo(argument[0], 360);
	var _s = modulo(argument[1], 360);

	var _diff = angle_difference(_i, _s - 90);

	return _s + 90 - _diff;
}
/* Copyright 2023 Springroll Games / Yosi */