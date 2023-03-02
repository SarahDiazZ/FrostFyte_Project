///@category Command Line Interface
/*
This object manages the command line interface.
Please note: You can disable it with the <cli_enable> macro.
*/
if (!cli_enable)
	{
	instance_destroy();
	exit;
	}
	
only_one();
in_focus = false;
history = [];
history_index = -1;
autocomplete = [];
cli = cli_init
	(
		[
			[
			"attack_set",
			["player_number", "attack_name", "script_name"],
			function(_args)
				{
				var _script = asset_get_index(_args[@ 3]);
				//Set to a string if the script doesn't exist, so you can use simple attacks
				if (_script == -1) then _script = _args[@ 3];
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					my_attacks[$ _args[@ 2]] = _script;
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"attack_script_run",
			["player_number", "script_name"],
			function(_args)
				{
				var _script = asset_get_index(_args[@ 2]);
				//Set to a string if the script doesn't exist, so you can use simple attacks
				if (_script == -1) then _script = _args[@ 2];
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					attack_start(_script);
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"damage",
			["player_number", "damage"],
			function(_args)
				{
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					if (match_has_stamina_set()) then stamina = _args[@ 2];
					else damage = round(real(_args[@ 2]));
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"KO",
			["player_number"],
			function(_args)
				{
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					knock_out();
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"stock",
			["player_number", "stock"],
			function(_args)
				{
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					stock = round(real(_args[@ 2]));
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"var",
			["player_number", "variable_name", "value"],
			function(_args)
				{
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					variable_instance_set(id, _args[@ 2], _args[@ 3]);
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"var_struct",
			["player_number", "struct_name", "variable_name", "value"],
			function(_args)
				{
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					variable_struct_set(variable_instance_get(id, _args[@ 2]), _args[@ 3], _args[@ 4]);
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"xy",
			["player_number", "x", "y"],
			function(_args)
				{
				with(obj_player)
					{
					if (player_number != _args[@ 1]) then continue;
					x = round(real(_args[@ 2]));
					y = round(real(_args[@ 3]));
					break;
					}
				},
			CLI_TYPE.player,
			],
			[
			"camera_zoom",
			["enable"],
			function(_args)
				{
				setting().camera_zoom_enable = bool(_args[@ 1]);
				if (!camera_can_zoom() && instance_exists(obj_game))
					{
					view_set_surface_id(0, -1);
					}
				},
			CLI_TYPE.gameplay,
			],
			[
			"fullscreen",
			[],
			function()
				{
				window_set_fullscreen(!window_get_fullscreen());
				},
			CLI_TYPE.general,
			],
			[
			"window_size",
			["scaling"],
			function(_args)
				{
				var _scale = clamp(round(real(_args[@ 1])), 1, 4);
				var _ww = screen_width * _scale;
				var _wh = screen_height * _scale;
				window_set_size(_ww, _wh);
				//Center the window
				window_set_position
					(
					(display_get_width() div 2) - (_ww div 2),
					(display_get_height() div 2) - (_wh div 2),
					);
				},
			CLI_TYPE.general,
			],
			[
			"game_setting",
			["name", "value"],
			function(_args)
				{
				variable_struct_set(setting(), _args[@ 1], _args[@ 2]);
				},
			CLI_TYPE.general,
			],
			[
			"engine_setting",
			["name", "value"],
			function(_args)
				{
				variable_struct_set(engine(), _args[@ 1], _args[@ 2]);
				},
			CLI_TYPE.general,
			],
		],
	);
	
array_sort
	(
	cli.list, 
	function(_a, _b)
		{
		return ord(string_char_at(_a[@ 0], 1)) - ord(string_char_at(_b[@ 0], 1));
		},
	);


/* Copyright 2023 Springroll Games / Yosi */