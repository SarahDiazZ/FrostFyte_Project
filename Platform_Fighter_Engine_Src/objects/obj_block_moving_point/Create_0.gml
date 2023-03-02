///@category Stages
/*
This object acts as a point in a path for a moving block.
It has two important variables in the Variable Definitions tab that must be set per instance in the room editor:
	- next_point: The id of the next point in the path
	- travel_time: How long the moving block should take to move to the next point
Please note: This object is not visible during gameplay.
*/
///@description Docs
assert(object_is(next_point.object_index, obj_block_moving_point),
	"[obj_block_moving_point: Create] The next_point is not a valid instance of obj_block_moving_point (",
	object_get_name(next_point.object_index), ")");
/* Copyright 2023 Springroll Games / Yosi */