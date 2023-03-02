///@category Player Actions
/*
Allows the player to fastfall by flicking the control stick downward, and returns true if they do.
If <fastfall_attack_hold> is true, then players only need to hold the stick down to fastfall.
This function is intended to be used during attacks.
*/
function fastfall_attack_try() {
	//Fastfalling cannot be done right after a plat drop
	if (can_fastfall)
		{
		if (vsp >= 0 && vsp != fastfall_speed)
			{
			if (fastfall_attack_hold)
				{
				if (stick_get_value(Lstick, DIR.down) > stick_flick_amount)
					{
					fastfall();
					return true;
					}
				}
			else
				{
				if (stick_flicked(Lstick, DIR.down, fastfall_buffer_time))
					{
					fastfall();
					return true;
					}
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */