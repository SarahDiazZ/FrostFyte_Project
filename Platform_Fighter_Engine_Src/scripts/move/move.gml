///@category Collisions
/*
Moves a player based on their previously set speeds.
Players can move down through platforms if they are tilting the control stick downward.
*/
function move() {
	speed_fraction();
	move_x();
	move_y(stick_tilted(Lstick, DIR.down));
}
/* Copyright 2023 Springroll Games / Yosi */