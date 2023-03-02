///@description
if (obj_game.game_time % timer == 0)
	{
	if (!swapped)
		{
		swapped = true;
		collision_flag_set(id, FLAG.plat, !collision_flag_exists(id, FLAG.plat));
		on = !on;
		}
	}
else
	{
	swapped = false;
	}
/* Copyright 2023 Springroll Games / Yosi */