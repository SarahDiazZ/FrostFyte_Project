function nspec_sword_swing() {
	//Neutral Special
	/*
	- Move around the right stick to swing the sword
	- The attack ends when the right stick returns to neutral, or stops moving
	- The swing has a tipper
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Speeds / Animation
	if (on_ground())
		{
		friction_gravity(slide_friction, grav, max_fall_speed);
		anim_sprite = spr_idle0;
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		anim_sprite = spr_jump_mid0;
		}
	var _trail_length = 4;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 10;
				callback_add(callback_draw_end, nspec_sword_swing_draw);
				
				change_facing(Rstick);
				
				custom_attack_struct.swings = [];
				
				//Add the initial direction
				var _dir = facing == 1 ? 0 : 180;
				if (stick_tilted(Rstick))
					{
					_dir = stick_get_direction(Rstick);
					}
					
				repeat(_trail_length)
					{
					array_push(custom_attack_struct.swings, _dir);
					}
				return;
				}
			//Swinging
			case 0:
				{
				//Swing direction
				if (stick_tilted(Rstick))
					{
					//Only create a hitbox if it is significantly different from the previous frame
					var _length = array_length(custom_attack_struct.swings);
					var _dir = stick_get_direction(Rstick);
					if (_length > 1)
						{
						var _min_angle_change = 7;
						if (abs(angle_difference(custom_attack_struct.swings[@ _length - 1], _dir)) >= _min_angle_change)
							{
							//Hitboxes
							if (attack_frame == 4)
								{
								for(var i = 0; i < _length; i++)
									{
									var _prev = custom_attack_struct.swings[@ i];
									//Normal
									var _len = 20;
									var _hitbox = hitbox_create_melee(lengthdir_x(_len, _prev) * facing, lengthdir_y(_len, _prev), 0.6, 0.6, 4, 7, 0.8, 5, 45, 1, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
									_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
									_hitbox.hit_sfx = snd_hit_weak2;
						
									//Tipper
									_len = 64;
									var _hitbox = hitbox_create_melee(lengthdir_x(_len, _prev) * facing, lengthdir_y(_len, _prev), 0.7, 0.7, 8, 7, 1, 12, 45, 1, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
									_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
									_hitbox.hit_sfx = snd_hit_strong2;
									}
								}
							else if (attack_frame < 4)
								{
								//Normal
								var _len = 20;
								var _hitbox = hitbox_create_melee(lengthdir_x(_len, _dir) * facing, lengthdir_y(_len, _dir), 0.6, 0.6, 4, 7, 0.8, 5, 45, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
								_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
								_hitbox.hit_sfx = snd_hit_weak2;
						
								//Tipper
								_len = 64;
								var _hitbox = hitbox_create_melee(lengthdir_x(_len, _dir) * facing, lengthdir_y(_len, _dir), 0.7, 0.7, 8, 7, 1, 12, 45, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
								_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
								_hitbox.hit_sfx = snd_hit_strong2;
								}
							}
						}
					array_push(custom_attack_struct.swings, _dir);
					}
				
				//Canceling
				if (attack_frame == 0)
					{
					var _length = array_length(custom_attack_struct.swings);
					if (_length == 0)
						{
						attack_phase++;
						attack_frame = 5;
						}
					//Array handling
					else
						{
						array_delete(custom_attack_struct.swings, 0, 1);
						}
					}
				break;
				}
			//Endlag
			case 1:
				{
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */