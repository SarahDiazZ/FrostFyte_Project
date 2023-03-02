function main_menu_ui_credits_button_step() {
	ui_button_step();
	
	if (ui_clicked)
		{
		menu_sound_play(snd_menu_alert);
		room_goto(rm_credits);
		}
}

/* Copyright 2023 Springroll Games / Yosi */