///@category Player Actions
/*
Changes the player's direction if they previously flicked the control stick opposite of the direction they are facing.
This is modeled after a common mechanic in platform fighters where flicking the control stick before using a special move will cause the player to turn around, hence the name "Reverse B".
For another special move turnaround function, see <b_reverse>.
*/
function reverse_b() {
	var _reverse = facing == 1 ? DIR.left : DIR.right;
	if (stick_check(Lstick, true, false, _reverse, undefined, undefined, stick_reverse_b_time))
		{
		facing *= -1;
		}
}
/* Copyright 2023 Springroll Games / Yosi */