///@category Gameplay
/*
Draws the entity's current sprite with the palette shader applied.
*/
function entity_draw_self() {
	assert(object_is(object_index, obj_entity), "[entity_draw_self] This script cannot be run on a non-entity object (", object_get_name(object_index), ")");

	//Fade value
	var _f = background_get_clear_amount();
		
	//Draw onto the surface
	surface_set_target(object_surface_get());
	draw_clear_alpha(c_white, 0);
	draw_sprite_ext(sprite_index, image_index, object_surface_size_half, object_surface_size_half, sign(image_xscale), 1, 0, c_white, 1);
	surface_reset_target();
	
	//Set up the shader and draw
	var _halfx = image_xscale * object_surface_size_half;
	var _halfy = image_yscale * object_surface_size_half;
	var _len = point_distance(0, 0, _halfx, _halfy);
	var _cx = lengthdir_x(_len, -45 + image_angle);
	var _cy = lengthdir_y(_len, -45 + image_angle);
	palette_shader_set(palette_base, palette_swap, 0.0, 1.0, _f, entity_outline, c_black, -1, -1, object_surface_get());
	draw_surface_ext(object_surface_get(), x - _cx, y - _cy, abs(image_xscale), image_yscale, image_angle, image_blend, image_alpha);
	shader_reset();
}
/* Copyright 2023 Springroll Games / Yosi */