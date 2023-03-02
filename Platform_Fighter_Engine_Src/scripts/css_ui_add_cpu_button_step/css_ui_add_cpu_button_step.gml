function css_ui_add_cpu_button_step() {
	ui_button_step();

	if (ui_clicked)
		{
		if (css_players_count() < max_players)
			{
			menu_sound_play(snd_menu_select);
			with(obj_css_ui)
				{
				var _cursor_index = engine().css_index_current;
				var _group = group_start_number + engine().css_index_current;
				var _player_id = css_player_add
					(
					-1, 
					DEVICE.none, 
					undefined, 
					true, 
					css_ui_player_custom_struct_build
						(
						-1,
						_cursor_index,
						_group,
						noone,
						862 + irandom_range(-20, 20), //Coordinates of the center of the Random character zone on the CSS
						164 + irandom_range(-20, 20),
						false,
						),
					);
				//Profile
				//Turn off all SCS for CPUs specifically
				var _cc = custom_controls_create();
				_cc.scs = array_create(SCS.LENGTH, false);
				var _profile = profile_create
					(
					"CPU " + string(css_players_count()), 
					_cc, 
					true,
					);
				css_player_set
					(
					_player_id, 
					CSS_PLAYER.profile,
					_profile,
					);
				
				//Refresh UI
				css_ui_refresh();
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */