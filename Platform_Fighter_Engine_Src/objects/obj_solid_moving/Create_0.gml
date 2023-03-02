///@category Stages
/*
A solid object that moves on a path through various <obj_block_moving_point>.
The "next_point" variable in the Variables tab must be set per instance in the Room Editor to the FIRST point the moving block should move to.
If a player would be squashed by moving solid blocks, they will be snapped out of solids in the direction the moving block is headed.
*/
///@description
GAME_STATE_OBJECT

event_inherited();

collision_flag_set(id, FLAG.solid, true);
/* Copyright 2023 Springroll Games / Yosi */