///@category Collisions
///@param {real} px			The x coordinate to target
///@param {real} py			The y coordinate to target
///@param {real} accel		The acceleration
///@param {real} max		The maximum speed the player can accelerate to
/*
Accelerates the player toward the given coordinates.
*/
function speed_set_towards_point_accel() {
	var _px = argument[0],
		_py = argument[1],
		_acc = argument[2],
		_max = argument[3];
	
	var _dist = min(point_distance(x ,y, _px, _py), _max),
		_dir = point_direction(x, y, _px, _py);

	speed_set
		(
		approach(hsp, lengthdir_x(_dist, _dir), _acc),
		approach(vsp, lengthdir_y(_dist, _dir), _acc),
		false, false
		);
}
/* Copyright 2023 Springroll Games / Yosi */