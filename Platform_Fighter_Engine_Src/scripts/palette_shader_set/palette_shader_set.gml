///@category Palettes
///@param {array} palette_base				The array of RGBA values for the base colors
///@param {arary} palette_swap				The array of RGBA values for the colors that will replace the base colors
///@param {real} [light]					The light value to add to the colors
///@param {real} [alpha]					The alpha value to multiply all the colors' alpha values by
///@param {real} [fade]						The fade value to multiply all the colors' RGB values by
///@param {bool} [outline]					Whether to drawn a single pixel outline or not
///@param {color} [outline_color]			The color of the outline
///@param {asset} [sprite]					The sprite that will be drawn with the shader on. Needed to calculate the outline texel size
///@param {int} [subimage]					The frame of the sprite that will be drawn with the shader on. Needed to calculate the outline texel size
///@param {int} [surface]					A surface to draw with the shader on, instead of a sprite. This overrides the "sprite" and "subimage" arguments
///@param {color} [flash_color]				The color of a flash to draw over the player
///@param {real} [flash_alpha]				The alpha of a flash to draw over the player
/*
Sets the palette shader to use the given palette arrays and other values.
Everything drawn after this function is called will use the shader, until <shader_reset> is called.
Normally the shader should be set up to draw a single sprite, but you can also set it up to draw a surface with the optional argument.
*/
function palette_shader_set() {
	if (setting().disable_shaders) then return false;
	
	var _palette_base = argument[0];
	var _palette_swap = argument[1];
	var _light = argument_count > 2 ? argument[2] : 0.0;
	var _alpha = argument_count > 3 ? argument[3] : 1.0;
	var _fade = argument_count > 4 ? argument[4] : 0.0;
	var _outline = argument_count > 5 ? argument[5] : false;
	var _outline_color = argument_count > 6 ? argument[6] : c_white;
	var _sprite = argument_count > 7 ? argument[7] : sprite_index;
	var _subimage = argument_count > 8 ? argument[8] : image_index;
	var _surface = argument_count > 9 ? argument[9] : noone;
	var _flash_color = argument_count > 10 ? argument[10] : c_white;
	var _flash_alpha = argument_count > 11 ? argument[11] : 0.0;
	
	//Set shader and uniforms
	var _count = array_length(_palette_base) div 4;
	var _tex = (_surface == noone)
		? sprite_get_texture(_sprite, _subimage)
		: surface_get_texture(_surface);
	var _ptw = texture_get_texel_width(_tex);
	var _pth = texture_get_texel_height(_tex);
	var _tint = (instance_exists(obj_stage_manager))
		? obj_stage_manager.stage_tint
		: [0.0, 0.0, 0.0];
	shader_set(shd_palette);
	
	shader_set_uniform_f_array(palette_shader_uniforms().uni_pb, _palette_base);
	shader_set_uniform_f_array(palette_shader_uniforms().uni_ps, _palette_swap);
	shader_set_uniform_i(palette_shader_uniforms().uni_c, _count);
	
	shader_set_uniform_f(palette_shader_uniforms().uni_l, _light);
	shader_set_uniform_f(palette_shader_uniforms().uni_a, _alpha);
	shader_set_uniform_f(palette_shader_uniforms().uni_f, _fade);
	shader_set_uniform_i(palette_shader_uniforms().uni_o, _outline);
	shader_set_uniform_f(palette_shader_uniforms().uni_ot, _ptw, _pth);
	shader_set_uniform_f
		(
		palette_shader_uniforms().uni_oc, 
		color_get_red  (_outline_color) / 255,
		color_get_green(_outline_color) / 255,
		color_get_blue (_outline_color) / 255,
		1.0,
		);
	shader_set_uniform_f(palette_shader_uniforms().uni_ti, _tint[@ 0], _tint[@ 1], _tint[@ 2]);
	shader_set_uniform_f
		(
		palette_shader_uniforms().uni_fl,
		color_get_red  (_flash_color) / 255,
		color_get_green(_flash_color) / 255,
		color_get_blue (_flash_color) / 255,
		_flash_alpha,
		);
	
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */