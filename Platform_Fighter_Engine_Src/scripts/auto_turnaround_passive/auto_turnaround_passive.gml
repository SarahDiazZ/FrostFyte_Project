function auto_turnaround_passive() {
	//Only works in non-team modes
	if (!setting().match_team_mode)
		{
		//Only works for certain states
		if (state == PLAYER_STATE.idle ||
			state == PLAYER_STATE.crouching ||
			state == PLAYER_STATE.shielding ||
			state == PLAYER_STATE.walking)
			{
			//Face the nearest alive player
			var _nearest = find_nearest_player(x, y);
			if (_nearest != noone)
				{
				var _facing = sign(_nearest.x - x);
				if (_facing != 0)
					{
					facing = _facing;
					}
				}
			}
		}
	
}
/* Copyright 2023 Springroll Games / Yosi */