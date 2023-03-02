function css_ui_match_settings_button_step() {
	ui_button_step();

	if (ui_clicked)
		{
		with(obj_css_ui)
			{
			if (state == CSS_STATE.normal)
				{
				menu_sound_play(snd_menu_select);
				state = CSS_STATE.match_settings;
				match_settings_current = 0;
				
				//The first cursor that clicked on the button is the selector
				var _cursor = other.ui_clicked_array[@ 0];
				var _array = css_players_get_array();
				for(var i = 0; i < array_length(_array); i++)
					{
					if (css_player_get(_array[@ i], CSS_PLAYER.custom).cursor == _cursor)
						{
						match_settings_selector = _array[@ i];
						break;
						}
					}
				//Update the UI cursor so it doesn't register a click again
				ui_cursor_update(_cursor, 0, 0, true, false, 0);
				}
			}
		}
	
	//Updating Text
	if (obj_css_ui.state == CSS_STATE.match_settings)
		{
		text = match_settings_string("Match Settings");
		}
}
/* Copyright 2023 Springroll Games / Yosi */