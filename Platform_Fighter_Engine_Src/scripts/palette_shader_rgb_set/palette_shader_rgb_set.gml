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
/*
Sets the RGB palette shader to use the given palette arrays and other values.
Everything drawn after this function is called will use the shader, until <shader_reset> is called.
Normally the shader should be set up to draw a single sprite, but you can also set it up to draw a surface with the optional argument.
The RGB palette shader is different from the normal palette shader because it ignores alpha when replacing colors.
For example, if you draw a red square at 0.5 alpha using the normal palette shader with a palette that is supposed to replace red values with blue values, it will not work unless the palette specifically has a red value with 0.5 alpha on it.
With the RGB shader, the red square would be changed to blue with 0.5 alpha.
*/
function palette_shader_rgb_set() {
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
	shader_set(shd_palette_rgb);
	
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
		1.0
		);
	shader_set_uniform_f(palette_shader_uniforms().uni_ti, _tint[@ 0], _tint[@ 1], _tint[@ 2]);
	
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */