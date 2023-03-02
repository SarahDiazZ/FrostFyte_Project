function css_ui_player_delete_button_step() {
	ui_button_step();

	if (ui_clicked)
		{
		with(obj_css_ui)
			{
			menu_sound_play(snd_menu_back);
			var _player_id = other.player_id
			var _custom = css_player_get(_player_id, CSS_PLAYER.custom);
			//Delete the player
			css_player_delete(_player_id);
			//Disconnect the controller
			mis_device_disconnect(_custom.device_id);
			//Destroy the UI
			ui_group_delete(_custom.group);
			//Delete UI Cursor
			ui_cursor_delete(_custom.cursor);
			//Refresh the UI
			css_ui_refresh();
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */