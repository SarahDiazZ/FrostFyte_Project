///@category Verlet
/*
A basic point in a verlet system.
You can create points with <verlet_system_point_add>.
It has forces such as gravity and air friction applied by the system.
If you want a point that does not move, use <obj_verlet_point_fixed>.
*/
event_inherited();

xprev = x;
yprev = y;
group = 0;

/* Copyright 2023 Springroll Games / Yosi */