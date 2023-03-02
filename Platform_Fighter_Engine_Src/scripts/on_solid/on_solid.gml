///@category Collisions
///@param {int} [x]			The x coordinate to check at
///@param {int} [y]			The y coordinate to check at
/*
Returns true if the player is standing on a solid block.
This function normally checks the player's current position, but you can optionally give it specific coordinates to check.
*/
function on_solid() {
	var _x, _y;
	_x = argument_count > 0 ? argument[0] : x;
	_y = argument_count > 1 ? argument[1] : y;

	return collision(_x, _y + 1, [FLAG.solid]);
}
/* Copyright 2023 Springroll Games / Yosi */