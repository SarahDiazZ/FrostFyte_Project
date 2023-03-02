function sss_ui_random_button_step() {
	ui_button_step();

	if (ui_clicked)
		{
		menu_sound_play(snd_menu_select);
		setting().match_stage = stage_choose_random();
		game_begin(rm_css, false, false);
		}
}
/* Copyright 2023 Springroll Games / Yosi */