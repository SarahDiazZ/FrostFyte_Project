///@category Stages
/*
A platform object that disappears and reappears on a preset timer.
The timer can be set per instance on the Variables tab in the Room Editor.
Warning: Overlapping platform objects will cause issues if the <platform_check_type> is not set to PLATFORM_CHECK_TYPE.precise.
*/
///@description
event_inherited();
collision_flag_set(id, FLAG.plat, true);
swapped = false;
on = true;
/* Copyright 2023 Springroll Games / Yosi */