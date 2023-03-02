function dspec3_overhead() {
	var _args = argument[0];
	var _x = _args[@ 0] - 32;
	var _y = _args[@ 1];
	
	//Charge variable
	if (!variable_struct_exists(custom_attack_struct, "dspec3_charge"))
		{
		custom_attack_struct.dspec3_charge = 0;
		}
	
	//Don't draw when the background is cleared
	if (background_get_clear_amount() > 0)
		{
		palette_shader_simple_set(palette_base, palette_swap);
		for(var i = 0; i < 3; i++)
			{
			draw_sprite_ext(spr_dspec3_bar, (custom_attack_struct.dspec3_charge > i) ? 1 : 0, _x, _y, 2, 2, 0, c_white, 1);
			_x += 32;
			}
		shader_reset();
		}
}
/* Copyright 2023 Springroll Games / Yosi */