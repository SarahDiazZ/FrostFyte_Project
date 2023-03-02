///@category Character Select Screen
/*
Returns true if the current list of players can be used in a match.
*/
function css_can_start_match() {
	//There must be 2 or more players
	var _num = array_length(engine().css_player_data);
	if (_num >= 2)
		{
		//Players cannot be holding tokens
		var _array = css_players_get_array();
		for(var i = 0; i < array_length(_array); i++)
			{
			if (css_player_get(_array[@ i], CSS_PLAYER.custom).token_held != noone) then return false;
			}
			
		//Team mode specific checks
		if (setting().match_team_mode)
			{
			//If all of the players are on the same team, the match can't start
			var _same_team = true;
			var _first_team = engine().css_player_data[@ 0][@ CSS_PLAYER.team];
			for(var i = 1; i < _num; i++)
				{
				if (engine().css_player_data[@ i][@ CSS_PLAYER.team] != _first_team)
					{
					_same_team = false;
					break;
					}
				}
			if (!_same_team)
				{
				return true;
				}
			else
				{
				return false;
				}
			}
		else
			{
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */