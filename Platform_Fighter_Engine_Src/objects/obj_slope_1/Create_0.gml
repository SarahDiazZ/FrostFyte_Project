///@category Stages
/*
A solid slope block.
The angle of the slope is stored in the "slope_angle" variable, while the normal angle is in "slope_normal".
The type of slope is stored in the "slope_type" variable, which is from the SLOPE_TYPE enum, and determines how players bounce off the slope in <check_tech>:
	- perpendicular_bounce: Players always bounce away at the "slope_normal" angle (perpendicular to the slope).
	- calculated_bounce: Players bounce based on the angle of impact.
Warning: The default slope type is "perpendicular_bounce" because "calculated_bounce" can cause issues if the angle of impact is too close to the slope's angle.
*/
///@description
event_inherited();
collision_flag_set(id, FLAG.solid, true);
collision_flag_set(id, FLAG.slope, true);

slope_angle = modulo(point_direction(0, 0, image_xscale, -image_yscale), 360);
slope_normal = slope_angle - 90;
if (sign(image_xscale) == -1 ^^ sign(image_yscale) == 1) then slope_normal += 180;

//slope_type = SLOPE_TYPE.perpendicular_bounce; //Set in the Variable Definitions menu

image_speed = 0;
/* Copyright 2023 Springroll Games / Yosi */