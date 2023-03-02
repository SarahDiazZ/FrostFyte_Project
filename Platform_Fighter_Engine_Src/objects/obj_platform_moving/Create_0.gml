///@category Stages
/*
A platform object that moves on a path through various <obj_block_moving_point>.
The "next_point" variable in the Variables tab must be set per instance in the Room Editor to the FIRST point the moving block should move to.
Warning: Overlapping platform objects will cause issues if the <platform_check_type> is not set to PLATFORM_CHECK_TYPE.precise.
*/
///@description
GAME_STATE_OBJECT

event_inherited();
collision_flag_set(id, FLAG.plat, true);
/* Copyright 2023 Springroll Games / Yosi */