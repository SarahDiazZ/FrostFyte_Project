function main_menu_ui_button_step() {
	ui_button_step();
	
	if (ui_clicked)
		{
		menu_sound_play(snd_menu_alert);
		main_menu_sidebar_choose(name);
		}
}
/* Copyright 2023 Springroll Games / Yosi */