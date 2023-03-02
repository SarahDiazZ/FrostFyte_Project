///@category Palettes
///@param {array} palette_base				The array of RGBA values for the base colors
///@param {arary} palette_swap				The array of RGBA values for the colors that will replace the base colors
/*
Sets the simple palette shader to use the given palette arrays.
Everything drawn after this function is called will use the shader, until <shader_reset> is called.
*/
function palette_shader_simple_set() {
	if (setting().disable_shaders) then return false;
	
	var _palette_base = argument[0];
	var _palette_swap = argument[1];
	
	//Set shader and uniforms
	var _count = array_length(_palette_base) div 4;
	shader_set(shd_palette_simple);

	shader_set_uniform_f_array(palette_shader_simple_uniforms().uni_pb, _palette_base);
	shader_set_uniform_f_array(palette_shader_simple_uniforms().uni_ps, _palette_swap);
	shader_set_uniform_i(palette_shader_simple_uniforms().uni_c, _count);
	
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */