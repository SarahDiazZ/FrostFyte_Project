///@category Collisions
/*
Moves a player based on their previously set speeds.
Players cannot move off the ground with this function. If they are already off the ground, they will not move at all.
*/
function move_grounded() {
	speed_fraction();
	move_x_grounded(sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index), hsp);
	move_y();
}
/* Copyright 2023 Springroll Games / Yosi */