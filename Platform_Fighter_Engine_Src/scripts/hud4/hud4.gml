function hud4() {
	var _args = argument[0];
	var _x = _args[@ 0];
	var _y = _args[@ 1];
	var _player = _args[@ 2];
	var _alpha = _args[@ 3];
	
	with(_player)
		{
		if (!variable_struct_exists(custom_passive_struct, "has_kunai"))
			{
			custom_passive_struct.has_kunai = true;
			}
		switch(player_hud_type)
			{
			case HUD_TYPE.normal:
				var _mult = _args[@ 4] ? 1 : -1;
				if (custom_passive_struct.has_kunai && attack_cooldowns[$ string(nspec4)] <= 0)
					{
					palette_shader_simple_rgb_set(palette_base, palette_swap);
					draw_sprite_ext(spr_nspec4_kunai, 0, _x, _y, 2 * _mult, 2, 0, c_white, _alpha);
					shader_reset();
					}
				else
					{
					draw_sprite_ext(spr_nspec4_kunai, 0, _x, _y, 2 * _mult, 2, 0, c_black, _alpha);
					}
				break;
			case HUD_TYPE.legacy:
				if (custom_passive_struct.has_kunai && attack_cooldowns[$ string(nspec4)] <= 0)
					{
					palette_shader_simple_rgb_set(palette_base, palette_swap);
					draw_sprite_ext(spr_nspec4_kunai, 0, _x + 32, _y - 32, 2, 2, 0, c_white, _alpha);
					shader_reset();
					}
				else
					{
					draw_sprite_ext(spr_nspec4_kunai, 0, _x + 32, _y - 32, 2, 2, 0, c_black, _alpha);
					}
				break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */