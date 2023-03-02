///@category Collisions
/*
To be used by child objects of <obj_block_moving>.
Returns an array of <obj_collidable> instances that are currently standing on top of the calling block, and have the "FLAG.ride" flag.
*/
function block_moving_find_riders() {
	var _array = [];
	with(obj_collidable)
		{
		if (!collision_flag_exists(id, FLAG.ride)) then continue;
		if (place_meeting(x, y + 1, other) && !place_meeting(x, y, other) && !(vsp < 0))
			{
			array_push(_array, id);
			}
		}
	return _array;
}
/* Copyright 2023 Springroll Games / Yosi */