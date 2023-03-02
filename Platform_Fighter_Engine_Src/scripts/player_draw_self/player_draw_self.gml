///@category Player Rendering
///@param {real} [x]						The x to draw the player's sprite at
///@param {real} [y]						The y to draw the player's sprite at
///@param {real} [scale_multiplier]			The scale multiplier to use
/*
Draws the player's sprite (based on their animation variables) with the palette shader applied.
Please note: The scale multiplier is applied on top of the existing "anim_scale" and "sprite_scale" variables.
*/
function player_draw_self() {
	assert(object_is(object_index, obj_player), "[player_draw_self] This script cannot be run on a non-player object (", object_get_name(object_index), ")");

	var _x = argument_count > 0 ? argument[0] : x,
		_y = argument_count > 1 ? argument[1] : y,
		_s = argument_count > 2 ? argument[2] : 1;
	
	if (anim_sprite != -1)
		{
		if (sprite_exists(anim_sprite))
			{
			surface_set_target(object_surface_get());
				
			//Protection for clipping masks
			var _colorwriteenable = gpu_get_colorwriteenable();
			gpu_set_colorwriteenable(true, true, true, true);
				
			//Draw onto the surface
			var _half = object_surface_size_half;
			draw_clear_alpha(c_white, 0);
			draw_sprite_ext
				(
				anim_sprite,
				clamp(floor(anim_frame), 0, sprite_get_number(anim_sprite) - 1),
				_half,
				_half,
				anim_scale * facing,
				anim_scale,
				0,
				c_white,
				1,
				);
				
			surface_reset_target();
				
			//Clipping masks
			gpu_set_colorwriteenable(_colorwriteenable);
				
			//Draw the surface
			//If shaders are disabled, use a specific blend color
			var _blend = c_white;
			if (setting().disable_shaders)
				{
				_blend = palette_color_get(palette_data, 0);
				}
			else
				{
				player_shader_set();
				}
				
			_half *= sprite_scale * _s;
			var _len = point_distance(0, 0, _half, _half);
			var _cx = lengthdir_x(_len, -45 + anim_angle);
			var _cy = lengthdir_y(_len, -45 + anim_angle);
			draw_surface_ext
				(
				object_surface_get(), 
				_x + (anim_offsetx * facing) + (-_cx), 
				_y + anim_offsety + (-_cy),
				sprite_scale * _s,
				sprite_scale * _s,
				anim_angle,
				_blend,
				1,
				);
					
			shader_reset();
			}
		else
			{
			crash("[player_draw_self] Anim sprite ", anim_sprite, " does not exist!");
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */