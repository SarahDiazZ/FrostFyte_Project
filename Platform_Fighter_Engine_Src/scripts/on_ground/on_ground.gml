///@category Collisions
///@param {int} [x]			The x coordinate to check at
///@param {int} [y]			The y coordinate to check at
///@param {int} [vsp]		The player's current vertical speed
/*
Returns true if the player is standing on the ground.
This function normally checks the player's current position, but you can optionally give it specific coordinates to check.
The player's vsp is used for platform collision checking.
*/
function on_ground() {
	var _x, _y, _vsp;
	_x = argument_count > 0 ? argument[0] : x;
	_y = argument_count > 1 ? argument[1] : y;
	_vsp = argument_count > 2 ? argument[2] : vsp;

	return (on_solid(_x, _y) || on_plat(_x, _y, _vsp));
}
/* Copyright 2023 Springroll Games / Yosi */