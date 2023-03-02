///@category Player Actions
/*
Allows the player to cling to walls, and returns true if they do.
The specific conditions vary based on the <wall_jump_type>.
*/
function check_wall_cling() {
	switch(wall_jump_type)
		{
		case WALL_JUMP_TYPE.jump_press:
			{
			if (can_wall_cling && wall_cling_timeout == 0 && wall_jumps > 0)
				{
				if (!on_ground())
					{
					if (input_held(INPUT.jump, 1))
						{
						if (stick_tilted(Lstick, DIR.right) && collision(x + wall_cling_check_distance, y, [FLAG.solid]))
							{
							state_set(PLAYER_STATE.wall_cling);
							speed_set(0, 0, false, false);
							facing = -1;
							return true;
							}
						if (stick_tilted(Lstick, DIR.left) && collision(x - wall_cling_check_distance, y, [FLAG.solid]))
							{
							state_set(PLAYER_STATE.wall_cling);
							speed_set(0, 0, false, false);
							facing = 1;
							return true;
							}
						}
					}
				}
			break;
			}
		case WALL_JUMP_TYPE.stick_flick:
			{
			if (can_wall_cling && wall_cling_timeout == 0)
				{
				if (!on_ground())
					{
					if (stick_tilted(Lstick, DIR.right) && collision(x + wall_cling_check_distance, y, [FLAG.solid]))
						{
						state_set(PLAYER_STATE.wall_cling);
						speed_set(0, 0, false, false);
						facing = -1;
						return true;
						}
					if (stick_tilted(Lstick, DIR.left) && collision(x - wall_cling_check_distance, y, [FLAG.solid]))
						{
						state_set(PLAYER_STATE.wall_cling);
						speed_set(0, 0, false, false);
						facing = 1;
						return true;
						}
					}
				}
			break;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */