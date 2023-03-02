function ui_button_image_create() {
	ui_button_create();

	if (sprite != noone)
		{
		sprite_index = sprite;
		image_speed = 0;
		image_index = frame;
		}
}
/* Copyright 2023 Springroll Games / Yosi */