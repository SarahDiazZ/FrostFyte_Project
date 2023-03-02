function main_menu_ui_button_web_create() {
	//Disable the button on web exports
	if (web_export || true)
		{
		var _c = c_ltgray;
		color_normal = _c;
		color_hover = _c;
		color_clicked = _c;
		anyone_can_interact = false;
		}
		
	ui_button_create();
}
/* Copyright 2023 Springroll Games / Yosi */