///@category Stages
/*
A basic platform object that can be jumped through.
Warning: Overlapping platform objects will cause issues if the <platform_check_type> is not set to PLATFORM_CHECK_TYPE.precise.
*/
///@description
event_inherited();
collision_flag_set(id, FLAG.plat, true);
/* Copyright 2023 Springroll Games / Yosi */