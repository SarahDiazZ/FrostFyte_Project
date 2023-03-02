///@description Draw the laser

if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Fade value
	var _f = background_get_clear_amount();
	
	//Draw without an outline
	palette_shader_set(palette_base, palette_swap, 0.0, 1.0, _f, false);
	
	//Laser
	if (custom_entity_struct.phase == 1)
		{
		for(var i = 0; i < 5; i++)
			{
			draw_sprite_ext(spr_fspec1_beam, 7, x + facing * (128 + (256 * i)), y, 2, 2, 0, c_white, 1);
			}
		}
	else if (custom_entity_struct.phase == 2)
		{
		if (custom_entity_struct.mode == 0)
			{
			var _frame = (25 - custom_entity_struct.timer) div 2;
			if (_frame <= 6)
				{
				for(var i = 0; i < 5; i++)
					{
					draw_sprite_ext(spr_fspec1_beam, _frame, x + facing * (128 + (256 * i)), y, 2, 2, 0, c_white, 1);
					}
				}
			}
		else
			{
			var _frame = (35 - custom_entity_struct.timer) div 4;
			if (_frame <= 6)
				{
				for(var i = 0; i < 5; i++)
					{
					draw_sprite_ext(spr_fspec1_beam, _frame, x + facing * (128 + (256 * i)), y, 2, 2, 0, c_white, 1);
					}
				}
			}
		}
		
	//Turret
	draw_self();	
	
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */