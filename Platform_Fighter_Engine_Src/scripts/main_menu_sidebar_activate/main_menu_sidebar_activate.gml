///@category Menus
///@param {bool} active			Whether the main menu sidebar should be active or not
/*
Activates or deactivates the main menu sidebar.
*/
function main_menu_sidebar_activate() {
	with(obj_main_menu_sidebar_ui)
		{
		menu_active = bool(argument[0]);
		menu_active_frame = 0;
		if (menu_active)
			{
			menu_sound_play(snd_menu_alert);
			}
		return menu_active;
		}
	crash("obj_main_menu_sidebar_ui did not exist when main_menu_sidebar_activate was called");
}
/* Copyright 2023 Springroll Games / Yosi */