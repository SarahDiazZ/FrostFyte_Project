function sss_ui_back_button_step() {
	ui_button_step();

	if (ui_clicked)
		{
		menu_sound_play(snd_menu_back);
		room_goto_previous();
		}
}
/* Copyright 2023 Springroll Games / Yosi */