///@category Player Actions
/*
Allows the player to drift left or right.
If "jump_is_dash_jump" is true, the player can drift up to the "max_air_speed_dash", otherwise speed is capped at the value of "max_air_speed".
If the player's speed is greater than the limit before drift acceleration is applied, the speed cannot be increased, only decreased, but it will not be capped.

For example, if the player has an hsp of 10 before this function is called, and a max_air_speed of 5, this function will NOT reduce the hsp to 5.
If the player holds right, they will not accelerate because their hsp is already greater than the max_air_speed.
If the player holds left, they will slow down as normal.

See <aerial_drift> for the alternate version of this function.
Please note: This function can be called even if the player isn't currently in the air.
*/
function aerial_drift_momentum() {
	//Allows characters to drift at higher speeds than the normal limit
	var _max_speed = jump_is_dash_jump ? max_air_speed_dash : max_air_speed;

	if (stick_tilted(Lstick, DIR.horizontal))
		{
		var _dir = sign(stick_get_value(Lstick, DIR.horizontal));
		if (_dir == 1 && hsp < _max_speed)
			{
			hsp += air_accel;
			hsp = min(hsp, _max_speed);
			}
		if (_dir == -1 && hsp > -_max_speed)
			{
			hsp -= air_accel;
			hsp = max(hsp, -_max_speed);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */