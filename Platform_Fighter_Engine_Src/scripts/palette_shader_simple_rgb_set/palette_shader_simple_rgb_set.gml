///@category Palettes
///@param {array} palette_base				The array of RGBA values for the base colors
///@param {arary} palette_swap				The array of RGBA values for the colors that will replace the base colors
/*
Sets the simple palette shader to use the given palette arrays.
Everything drawn after this function is called will use the shader, until <shader_reset> is called.
The RGB palette shader is different from the normal palette shader because it ignores alpha when replacing colors.
For example, if you draw a red square at 0.5 alpha using the normal palette shader with a palette that is supposed to replace red values with blue values, it will not work unless the palette specifically has a red value with 0.5 alpha on it.
With the RGB shader, the red square would be changed to blue with 0.5 alpha.
*/
function palette_shader_simple_rgb_set() {
	if (setting().disable_shaders) then return false;
	
	var _palette_base = argument[0];
	var _palette_swap = argument[1];

	//Set shader and uniforms
	var _count = array_length(_palette_base) div 4;
	shader_set(shd_palette_simple_rgb);
	
	shader_set_uniform_f_array(palette_shader_simple_uniforms().uni_pb, _palette_base);
	shader_set_uniform_f_array(palette_shader_simple_uniforms().uni_ps, _palette_swap);
	shader_set_uniform_i(palette_shader_simple_uniforms().uni_c, _count);
	
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */