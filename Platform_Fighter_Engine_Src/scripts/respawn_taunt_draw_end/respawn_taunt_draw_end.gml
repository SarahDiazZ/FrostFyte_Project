///@category Player Actions
/*
The draw end script assigned to players during respawn taunts that draws the respawn platform.
*/
function respawn_taunt_draw_end() {
	if (!setting().disable_shaders)
		{
		shader_set(shd_fade);
		shader_set_uniform_f(shader_get_uniform(shd_fade, "fade_amount"), 1 + (sin(obj_game.current_frame / 10) * 0.05)); 
		}
	draw_sprite_ext
		(
		spr_respawn_platform, 
		0, 
		x, 
		(bbox_bottom - 1), 
		(sprite_scale * ((sprite_get_width(anim_sprite) + 16) / sprite_get_width(spr_respawn_platform))), 
		sprite_scale, 
		0, 
		image_blend, 
		image_alpha,
		);
	shader_reset();
}
/* Copyright 2023 Springroll Games / Yosi */