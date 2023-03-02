///@category Verlet
/*
A stick that connects two points in a verlet system.
You can create sticks with <verlet_system_stick_add>.
The stick will only move points if their distance exceeds the "length" of the stick.
If you want the stick to try to keep the points at the exact length, use <obj_verlet_stick_rigid>.
*/
event_inherited();

length = -1;
point1 = noone;
point2 = noone;
group = 0;
image_blend = c_white;

/* Copyright 2023 Springroll Games / Yosi */