function ui_button_step() {
	//Change the button color
	if (ui_click_hold)
		{
		image_blend = color_clicked;
		}
	else if (ui_hovered)
		{
		image_blend = color_hover;
		}
	else
		{
		image_blend = color_normal;
		}
	
	//Allow for transparency (but not fully invisible buttons, since this would mess up any place the button color is set without an alpha value).
	var _extracted_alpha = (image_blend >> 24) / 255;
	if (_extracted_alpha > 0) then image_alpha = _extracted_alpha;
	else image_alpha = 1;
}
/* Copyright 2023 Springroll Games / Yosi */