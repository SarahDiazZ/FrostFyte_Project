///@category Gameplay
/*
Creates all of the player instances at the <obj_player_spawner> locations, and passes the necessary data to each.
*/
function players_spawn() {
	//Loop through each player in the match and spawn
	//If there are not enough player spawners in the room, then not all of the players will spawn
	var _num_of_spawners = instance_number(obj_player_spawner);
	var _num_of_players = array_length(engine().player_data);
	var _colors_taken = [];
	for(var i = 0; i < min(_num_of_players, _num_of_spawners); i++)
		{
		var _s = instance_find(obj_player_spawner, i);
		with(instance_create_layer(_s.x, _s.y, _s.layer, obj_player))
			{
			//Pass in character script
			var _data = engine().player_data[@ i];
			var _character_number = _data[@ PLAYER_DATA.character];
			var _char = character_data_get_all()[@ _character_number];
			character = _character_number;
			character_script = _char[@ CHARACTER_DATA.script];
		
			//Assign Properties
			device = _data[@ PLAYER_DATA.device];
			device_type = _data[@ PLAYER_DATA.device_type];
			player_number = i;
			player_color = _data[@ PLAYER_DATA.color];
			player_profile = _data[@ PLAYER_DATA.profile];
			is_cpu = _data[@ PLAYER_DATA.is_cpu];
			cpu_type = _data[@ PLAYER_DATA.cpu_type];
			player_team = _data[@ PLAYER_DATA.team];
		
			//Custom controls
			var _cc = profile_get(player_profile, PROFILE.custom_controls);
			custom_controls = custom_controls_unpack(_cc, device_type);
			
			//Right stick input
			right_stick_input = _cc.right_stick_input;
			
			//Special Control Settings
			scs = _cc.scs;
			
			//Advanced Controller Settings
			acs = _cc.acs;
			
			//CPU Controls
			if (is_cpu)
				{
				custom_controls = [];
				scs = array_create(SCS.LENGTH, false);
				}
			
			//Player name
			player_name = profile_get(player_profile, PROFILE.name);
			
			//Make sure the color doesn't overlap with anyone else!
			var _already_taken = false;
			var _possible_colors = character_data_get(character, CHARACTER_DATA.palette_data).columns;
			repeat(_possible_colors)
				{
				_already_taken = false;
				for(var m = 0; m < array_length(_colors_taken); m++)
					{
					var _other = _colors_taken[@ m];
					if (_other.player_color == player_color && _other.character == character)
						{
						log("Same color as another player - switching colors!");
						_already_taken = true;
						player_color = modulo(player_color + 1, _possible_colors);
						if (player_color == 0) then player_color++; //Can't choose the first column of a palette!
						break;
						}
					}
				if (!_already_taken) then break;
				} 
			array_push(_colors_taken, { player_color : player_color, character : character });
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */