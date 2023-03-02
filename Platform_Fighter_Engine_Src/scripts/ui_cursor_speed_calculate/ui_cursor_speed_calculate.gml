///@category UI
///@param {real} move_x			The x amount to move
///@param {real} move_y			The y amount to move
///@param {real} max_speed		The maximum speed the cursor can move
/*
Returns the speed a cursor can move at based on the x and y amounts given, and the max speed.
The exact formula is: min(point_distance(0, 0, _x * _max_speed, _y * _max_speed), _max_speed)
*/
function ui_cursor_speed_calculate() {
	var _x = argument[0];
	var _y = argument[1];
	var _max_speed = argument[2];
	return min(point_distance(0, 0, _x * _max_speed, _y * _max_speed), _max_speed);
}
/* Copyright 2023 Springroll Games / Yosi */