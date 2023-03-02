///@category Character Select Screen
/*
Converts the character select screen data to engine player data that can be loaded into a match. Custom data is also transferred.
*/
function css_engine_player_data_save() {
	//Clear existing data
	var _num_of_players = array_length(engine().css_player_data);
	player_data_clear();
		
	//Convert CSS player data to engine player data
	for(var i = 0; i < _num_of_players; i++)
		{
		var _player = engine().css_player_data[@ i];
		var _color = _player[@ CSS_PLAYER.color];
			
		//Random characters
		var _character = _player[@ CSS_PLAYER.character];
		var _is_random = (character_data_get(_character, CHARACTER_DATA.name) == "Random");
		if (_is_random)
			{
			_character = character_choose_random();
			}
				
		//Set the data
		player_data_create
			(
			_character,
			_color,
			_player[@ CSS_PLAYER.device],
			_player[@ CSS_PLAYER.device_type],
			_player[@ CSS_PLAYER.profile],
			_is_random,
			_player[@ CSS_PLAYER.is_cpu],
			_player[@ CSS_PLAYER.cpu_type],
			_player[@ CSS_PLAYER.team],
			_player[@ CSS_PLAYER.custom],
			);
		}
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */