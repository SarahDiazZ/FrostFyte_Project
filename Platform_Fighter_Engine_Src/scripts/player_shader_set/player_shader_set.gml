///@category Player Engine Scripts
/*
Sets the palette shader with specific values.
Everything drawn after this function is called will use the shader, until <shader_reset> is called.
*/
function player_shader_set() {
	//Light change and alpha change
	var _light = 0.0, _alpha = 1.0;
	
	if (hurtbox.inv_type == INV.invincible && !is_knocked_out())
		{
		_light = 0.5;
		_alpha = 0.5;
		}
		
	_alpha *= anim_alpha;

	//Set up the shader
	var _outline_color = setting().match_team_mode ? player_color_get(player_team) : player_outline_color;
	palette_shader_set(palette_base, palette_swap, _light, _alpha, fade_value, player_outline, _outline_color, -1, -1, object_surface_get(), flash_color, flash_alpha);
}
/* Copyright 2023 Springroll Games / Yosi */