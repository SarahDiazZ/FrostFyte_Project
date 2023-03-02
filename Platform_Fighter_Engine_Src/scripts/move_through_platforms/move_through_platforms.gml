///@category Collisions
/*
Moves a player based on their previously set speeds.
Players will move downward through platforms.
*/
function move_through_platforms() {
	speed_fraction();
	move_x();
	move_y(true);
}
/* Copyright 2023 Springroll Games / Yosi */