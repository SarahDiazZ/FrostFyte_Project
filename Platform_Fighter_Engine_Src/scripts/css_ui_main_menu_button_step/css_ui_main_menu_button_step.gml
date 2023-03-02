function css_ui_main_menu_button_step() {
	ui_button_step();

	//Hold to go back
	if (obj_css_ui.css_back_button_timer > 0)
		{
		image_blend = merge_color(color_normal, c_red, obj_css_ui.css_back_button_timer / 45);
		}

	//Opening the sidebar
	if (ui_clicked)
		{
		obj_css_ui.state = CSS_STATE.main_menu;
		main_menu_sidebar_activate(true);
		
		//Update the UI cursor so it doesn't register a click again
		var _cursor = ui_clicked_array[@ 0];
		ui_cursor_update(_cursor, 0, 0, true, false, 0);
		}
	else if (obj_css_ui.css_back_button_timer >= 45)
		{
		obj_css_ui.state = CSS_STATE.main_menu;
		main_menu_sidebar_activate(true);
		}
}
/* Copyright 2023 Springroll Games / Yosi */