///@category Menus
///@param {color} color		The background color to set
/*
Sets the color of <obj_menu_background>.
*/
function menu_background_color_set() {
	with(obj_menu_background)
		{
		color = argument[0];
		return true;
		}
	crash("obj_menu_background did not exist when menu_background_color_set was called");
}
/* Copyright 2023 Springroll Games / Yosi */