///@category Player Actions
/*
Allows the player to drift left or right.
If "jump_is_dash_jump" is true, the player can drift up to the "max_air_speed_dash", otherwise speed is capped at the value of "max_air_speed".
If the player's speed is greater than the limit even before drift acceleration is applied, the speed will still be capped. See <aerial_drift_momentum> for the alternate version of this function.
Please note: This function can be called even if the player isn't currently in the air.
*/
function aerial_drift() {
	var _max_speed = jump_is_dash_jump ? max_air_speed_dash : max_air_speed;

	if (stick_tilted(Lstick, DIR.horizontal))
		{
		var _dir = sign(stick_get_value(Lstick, DIR.horizontal));
		hsp += air_accel * _dir;
		}
	
	hsp = clamp(hsp, -_max_speed, _max_speed);
}
/* Copyright 2023 Springroll Games / Yosi */