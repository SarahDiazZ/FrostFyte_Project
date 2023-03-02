///@category Player Actions
/*
Changes the player's direction and horizontal speed if they are tilting the control stick opposite of the direction they are facing.
This is modeled after a common mechanic in platform fighters where flicking the control stick right after using a special move will cause the player to turn around, hence the name "B Reverse".
For another special move turnaround function, see <reverse_b>.
*/
function b_reverse() {
	if (stick_tilted(Lstick, DIR.horizontal) && sign(stick_get_value(Lstick, DIR.horizontal)) != facing)
		{
		hsp *= -1;
		facing *= -1;
		}
}
/* Copyright 2023 Springroll Games / Yosi */