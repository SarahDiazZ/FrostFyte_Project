///@category Player Actions
/*
Allows the player to fastfall by flicking the control stick downward, and returns true if they do.
*/
function fastfall_try() {
	//If you flick down on the stick and are already falling, fastfall.
	//Fastfalling cannot be done right after a plat drop
	if (can_fastfall)
		{
		if (vsp >= 0 && vsp < floor(fastfall_speed))
			{
			if (stick_flicked(Lstick, DIR.down, fastfall_buffer_time))
				{
				fastfall();
				return true;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */