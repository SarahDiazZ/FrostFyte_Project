function ui_fade_draw() {
	draw_set_alpha(fade);
	draw_set_color(image_blend);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1);
}
/* Copyright 2023 Springroll Games / Yosi */