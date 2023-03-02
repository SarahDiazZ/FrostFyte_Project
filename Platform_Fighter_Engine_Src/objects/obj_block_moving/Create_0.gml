///@category Collisions
/*
obj_block_moving is the parent object of all moving "block" objects - <obj_solid_moving> and <obj_platform_moving>.
It is a child of <obj_collidable>.
obj_block_moving should never be directly put in rooms.
*/
GAME_STATE_OBJECT

sync_id_assign();

//Variables tab
//next_point = noone;

event_inherited();
collision_flag_set(id, FLAG.block, true);

start_x = x;
start_y = y;
time = 0;
custom_block_moving_struct = {};

if (next_point != noone)
	{
	assert
		(
		object_is(next_point.object_index, obj_block_moving_point),
		"[obj_block_moving: Create] The next_point is not a valid instance of obj_block_moving_point (",
		object_get_name(next_point.object_index),
		")",
		);
	}
/* Copyright 2023 Springroll Games / Yosi */