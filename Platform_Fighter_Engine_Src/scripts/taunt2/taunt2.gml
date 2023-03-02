///Taunt for character2
function taunt2() {
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;

	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction);

	//Respawn platform taunting
	var _respawn_platform = (respawn_platform_taunt_enable && array_contains(callback_passive, respawn_taunt_passive));
	
	//Cancel in air
	if (!_respawn_platform)
		{
		if (run && cancel_air_check()) run = false;
		}

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_taunt2;
				anim_speed = (anim_calculate_speed(spr_taunt2, 20) / 2);
				attack_frame = 20;
				charge = 0;
				return;
				}
			case 0:
				{
				if (attack_frame == 0)
					{
					anim_speed = 0;
					anim_frame = 7;
					
					//Hold the pose until the Taunt input is no longer held down
					if (!input_held(INPUT.taunt))
						{
						attack_phase++;
						attack_frame = 20;
						anim_speed = (anim_calculate_speed(spr_taunt2, 20) / 2);
						}
					else
						{
						//Charging up
						charge++;
						
						if (charge > 120)
							{
							fade_value = approach(fade_value, 0, 0.11);
							camera_shake(1);
							if (charge % 30 == 0)
								{
								var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x + 16, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
								_vfx.vfx_xscale = -2;
								var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x - 16, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
								_vfx.vfx_xscale = 2;
								}
							}
						if (charge >= 260)
							{
							camera_shake(2);
							if (charge % 20 == 0)
								{
								game_sound_play(snd_c4);
								}
							}
						
						//Explosion
						if (charge >= 360)
							{
							game_sound_play(snd_hit_explosion4);
							background_clear_activate(30, palette_color_get(palette_data, 0));
							var _hitbox = hitbox_create_melee(0, 0, 20, 20, 41, 60, 0, 16, 30, 1, SHAPE.circle, 0, FLIPPER.from_hitbox_center_horizontal);
							_hitbox.techable = false;
							_hitbox.custom_hitstun = 60;
							_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
							_hitbox.hit_sfx = -1;
							vfx_create(spr_dspec_c4_explosion, 1, 0, 34, x, y, 2, 0);
							attack_phase = 2;
							attack_frame = 1;
							}
						}
					}
				break;
				}
			case 1:
				{
				if (attack_frame == 0)
					{
					if (!_respawn_platform)
						{
						attack_stop(PLAYER_STATE.idle);
						}
					else
						{
						//Go back to the respawn state
						var _time_remaining = state_frame;
						attack_stop(PLAYER_STATE.respawning);
						state_frame = _time_remaining;
						}
					}
				break;
				}
			case 2:
				{
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					knock_out();
					}
				break;
				}
			default: break;
			}
		}

	if (!_respawn_platform)
		{
		move_grounded();
		}
}
/* Copyright 2023 Springroll Games / Yosi */