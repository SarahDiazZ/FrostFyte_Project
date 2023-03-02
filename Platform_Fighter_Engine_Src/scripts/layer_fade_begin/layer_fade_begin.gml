///@category Backgrounds
/*
Turns on the fade shader.
This function is meant to be assigned to a layer.
*/
function layer_fade_begin() {
	fade_shader_set();

	if (surface_exists(obj_game.game_surface))
		{
		if (game_surface_enable) surface_set_target(obj_game.game_surface);
		}
}
/* Copyright 2023 Springroll Games / Yosi */