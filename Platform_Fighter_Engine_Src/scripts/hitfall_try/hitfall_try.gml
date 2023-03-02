///@category Player Actions
///@func hitfall_try()
///@desc Allows you to fastfall if you hit the opponent
/*
Allows the player to hitfall if hitfalling was previously enabled with <allow_hitfall>.
Please note: This function is automatically called by <obj_player> during attacks.
*/
function hitfall_try() {
	if (can_hitfall)
		{
		//If you have hit an attack
		if (attack_connected())
			{
			if (stick_flicked(Lstick, DIR.down))
				{
				fastfall();
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */