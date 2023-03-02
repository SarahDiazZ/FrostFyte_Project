///@description
image_blend = make_color_hsv((current_time / 100) % 255, 200, 255);

if (current_texture < array_length(textures_needed))
	{
	log("Prefetching texture group ", textures_needed[current_texture]);
	texture_prefetch(textures_needed[current_texture]);
	current_texture++;
	}
else if (load_time <= 0)
	{
	room_goto(setting().match_stage);
	exit;
	}

load_time--;
/* Copyright 2023 Springroll Games / Yosi */