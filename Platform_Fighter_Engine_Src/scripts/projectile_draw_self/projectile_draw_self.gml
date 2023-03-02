///@category Hitboxes
/*
Draws the projectiles's current sprite with the palette shader applied.
*/
function projectile_draw_self() {
	assert(object_is(object_index, obj_hitbox_projectile), "[projectile_draw_self] This script cannot be run on a non-projectile object (", object_get_name(object_index), ")");

	if (overlay_sprite == -1) then return;

	//Fade value
	var _f = background_get_clear_amount();
		
	//Draw onto the surface
	surface_set_target(object_surface_get());
	draw_clear_alpha(c_white, 0);
	draw_sprite_ext(overlay_sprite, overlay_frame, object_surface_size_half, object_surface_size_half, overlay_facing, 1, 0, overlay_color, 1);
	surface_reset_target();
	
	//Set up the shader and draw
	var _half = overlay_scale * object_surface_size_half;
	var _len = point_distance(0, 0, _half, _half);
	var _cx = lengthdir_x(_len, -45 + overlay_angle);
	var _cy = lengthdir_y(_len, -45 + overlay_angle);
	palette_shader_set(owner.palette_base, owner.palette_swap, 0.0, overlay_alpha, _f, projectile_outline, c_black, -1, -1, object_surface_get());
	draw_surface_ext(object_surface_get(), x - _cx, y - _cy, abs(overlay_scale), overlay_scale, overlay_angle, c_white, 1);
	shader_reset();
}
/* Copyright 2023 Springroll Games / Yosi */