///@category Character Select Screen
/*
Loads engine player data (and previously saved CSS player data) and recreates the character select screen.
*/
function css_engine_player_data_load() {
	//Reset
	css_players_clear();
		
	//Load in any engine player data
	var _num = array_length(engine().player_data);
	if (_num > 0)
		{
		for(var i = 0; i < _num; i++)
			{
			var _player = engine().player_data[@ i];
				
			//Add the CSS player
			css_player_add
				(
				_player[@ PLAYER_DATA.device],
				_player[@ PLAYER_DATA.device_type],
				_player[@ PLAYER_DATA.profile],
				_player[@ PLAYER_DATA.is_cpu],
				_player[@ PLAYER_DATA.custom],
				);
			var _css_player = engine().css_player_data[@ i];
			_css_player[@ CSS_PLAYER.color] = _player[@ PLAYER_DATA.color];
			_css_player[@ CSS_PLAYER.cpu_type] = _player[@ PLAYER_DATA.cpu_type];
			_css_player[@ CSS_PLAYER.team] = _player[@ PLAYER_DATA.team];
				
			//Random character
			if (_player[@ PLAYER_DATA.is_random])
				{
				_css_player[@ CSS_PLAYER.character] = character_find("Random");
				}
			//Other characters
			else
				{
				_css_player[@ CSS_PLAYER.character] = _player[@ PLAYER_DATA.character];
				}
			}
		}
	return;
}
/* Copyright 2023 Springroll Games / Yosi */