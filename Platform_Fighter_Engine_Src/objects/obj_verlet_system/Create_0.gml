///@category Verlet
/*
This object manages a verlet physics system, which contains instances of <obj_verlet_point>, <obj_verlet_point_fixed>, <obj_verlet_stick>, and <obj_verlet_stick_rigid>.
You can create a system with <verlet_system_create>.
*/
//Instance arrays
verlet_points = [];
verlet_sticks = [];

//System variables
verlet_move_script = -1;
verlet_draw_script = -1;
verlet_grav = 0.3;
verlet_grav_dir = 270;
verlet_grav_x = 0;
verlet_grav_y = 0.3;
verlet_air_resist = 0.02;
verlet_bounce_multiplier = 0.6;
verlet_sticks_iterations = 3;
verlet_sticks_strength_multiplier = 0.9; //Only applies to default sticks, not rigid sticks

/* Copyright 2023 Springroll Games / Yosi */