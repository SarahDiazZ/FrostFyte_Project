function css_ui_player_team_button_step() {
	//Change the color
	color_normal = player_color_get(css_player_get(player_id, CSS_PLAYER.team));
	color_hover = merge_color(color_normal, c_black, 0.1);
	
	ui_button_step();
	
	if (ui_clicked)
		{
		menu_sound_play(snd_menu_select);
		css_player_set
			(
			player_id, 
			CSS_PLAYER.team,
			modulo
				(
				css_player_get(player_id, CSS_PLAYER.team) + 1,
				max_teams,
				),
			);
		}
		
	//Text
	text = "Team " + string(css_player_get(player_id, CSS_PLAYER.team) + 1);
}
/* Copyright 2023 Springroll Games / Yosi */