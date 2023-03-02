///@category Menus
/*
Returns true if the main menu sidebar is open.
You can open it with <main_menu_sidebar_activate>.
*/
function main_menu_sidebar_is_open() {
	with(obj_main_menu_sidebar_ui)
		{
		return menu_active;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */