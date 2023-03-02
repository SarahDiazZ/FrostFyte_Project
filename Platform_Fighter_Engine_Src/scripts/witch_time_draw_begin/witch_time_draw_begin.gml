function witch_time_draw_begin() {
	//Variables
	var _p = custom_passive_struct;
	if (!variable_struct_exists(_p, "witch_time_frame")) then _p.witch_time_frame = 0;
	if (!variable_struct_exists(_p, "witch_time_x")) then _p.witch_time_x = x;
	if (!variable_struct_exists(_p, "witch_time_y")) then _p.witch_time_y = y;
	
	//Draw the clock
	draw_sprite_ext(spr_dspec_witch_time_clock, 1, x, y, 2, 2, -_p.witch_time_frame, c_white, 1);
	draw_sprite_ext(spr_dspec_witch_time_clock, 0, x, y, 2, 2, (_p.witch_time_frame / 240) * 360, c_white, 1);
	
	//Draw the player
	var _cached_alpha = anim_alpha;
	anim_alpha = 1 - (self_hitlag_frame / 7);
	player_draw_self(x + hsp, y + vsp);
	anim_alpha = (self_hitlag_frame / 7);
	player_draw_self(_p.witch_time_x, _p.witch_time_y);
	anim_alpha = _cached_alpha;
}
/* Copyright 2023 Springroll Games / Yosi */