if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	entity_draw_self();
	
	//Draw warning signs over the target's head
	var _life = custom_entity_struct.lifetime;
	if (_life < 30)
		{
		var _color = palette_color_get(palette_data, 1);
		with(custom_ids_struct.target)
			{
			if (!is_knocked_out())
				{
				draw_sprite_ext(spr_final_smash1_reticle, 6 + ((_life / 6) % 3), x, bbox_top - 48, 2, 2, 0, _color, 1);
				}
			}
		}
	
	if (game_surface_enable) surface_reset_target();
	}

/* Copyright 2023 Springroll Games / Yosi */