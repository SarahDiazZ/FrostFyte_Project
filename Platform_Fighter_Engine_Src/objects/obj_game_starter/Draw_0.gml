///@description Logo Animation
if (frame > 15)
	{
	image_x = ceil(lerp(image_x, 256, 0.1));
	text_x = ceil(lerp(text_x, 554, 0.1));
	image_alpha = lerp(image_alpha, 1, 0.05);
	draw_sprite_ext(spr_logo_128, 0, image_x, y, 1, 1, 0, c_white, image_alpha);
	draw_sprite_ext(spr_logo_text, 0, text_x, y, 1, 1, 0, c_white, image_alpha);
	}
/* Copyright 2023 Springroll Games / Yosi */