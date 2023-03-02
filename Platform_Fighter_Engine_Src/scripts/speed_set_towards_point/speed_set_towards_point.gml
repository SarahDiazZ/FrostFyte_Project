///@category Collisions
///@param {real} px			The x coordinate to target
///@param {real} py			The y coordinate to target
///@param {real} speed		The speed
/*
Sets the player's speed to move them towards a point.
*/
function speed_set_towards_point() {
	var _px = argument[0],
		_py = argument[1],
		_spd = argument[2];
	
	var _dist = min(point_distance(x, y, _px, _py), _spd),
		_dir = point_direction(x, y, _px, _py);

	speed_set(lengthdir_x(_dist, _dir), lengthdir_y(_dist, _dir), false, false);
}
/* Copyright 2023 Springroll Games / Yosi */