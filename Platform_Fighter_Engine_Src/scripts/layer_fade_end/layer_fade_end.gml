///@category Backgrounds
/*
Turns off the fade shader.
This function is meant to be assigned to a layer.
*/
function layer_fade_end() {
	shader_reset();

	if (surface_exists(obj_game.game_surface))
		{
		if (game_surface_enable) surface_reset_target();
		}
}
/* Copyright 2023 Springroll Games / Yosi */