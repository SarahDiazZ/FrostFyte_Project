///@category Player Actions
/*
Allows the player to drop through platforms, and returns true if they do.
This also restricts players from fastfalling until they move the control stick upwards and then flick down again.
*/
function check_drop_through() {
	//Drops through a platform
	//If there's a platform under you but not a solid
	if (!on_solid(x, y) && on_plat(x, y))
		{
		//If the stick was flicked
		if (stick_flicked(Lstick, DIR.down))
			{
			//Move a pixel down so gravity will take effect
			if (!collision(x, y + 1, [FLAG.solid]))
				{
				y += 1;
				}
			vsp = platform_drop_speed;
			state_set(PLAYER_STATE.aerial);
			//Set variable to restrict fastfalling
			can_fastfall = false;
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */