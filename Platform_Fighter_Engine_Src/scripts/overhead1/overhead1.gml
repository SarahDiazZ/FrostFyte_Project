function overhead1() {
	var _args = argument[0];
	var _x = _args[@ 0];
	var _y = _args[@ 1] + 38;
	
	//Don't draw when the background is cleared
	if (background_get_clear_amount() > 0)
		{
		if (state == PLAYER_STATE.attacking)
			{
			if (attack_script == dspec1 && attack_phase == 0)
				{
				//Charge variable
				if (!variable_struct_exists(custom_attack_struct, "dspec1_charge"))
					{
					custom_attack_struct.dspec1_charge = 0;
					}
					
				var _c = c_black;
				var _w = 28;
				var _h = 7;
				draw_rectangle_color(_x - _w, _y - _h, _x + _w, _y + _h, _c, _c, _c, _c, false);
				_c = palette_color_get(palette_data, 1);
				_w = 26;
				_h = 5;
				var _percent = clamp(custom_attack_struct.dspec1_charge / 180, 0, 1);
				draw_rectangle_color(_x - _w, _y - _h, _x - _w + (_w * 2 * _percent), _y + _h, _c, _c, _c, _c, false);
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */