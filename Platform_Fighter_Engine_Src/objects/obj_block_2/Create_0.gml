///@category Collisions
/*
obj_block is the parent object of all nonmoving "block" objects - <obj_solid>, <obj_slope>, <obj_platform>, and <obj_platform_blinker>.
It is a child of <obj_collidable>.
obj_block should never be directly put in rooms.
*/
event_inherited();
collision_flag_set(id, FLAG.block, true);
/* Copyright 2023 Springroll Games / Yosi */