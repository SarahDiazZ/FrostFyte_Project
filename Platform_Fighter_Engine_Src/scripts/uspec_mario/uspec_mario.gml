function uspec_mario() {
	//Up Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_frame = 0;
				anim_sprite = spr_uspec_mario;
				anim_speed = 0;
			
				parry_stun_time = 60;
				landing_lag = 15;
				speed_set(0, 0, false, false);
				attack_frame = 4;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 1)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 2;
				
					speed_set(4 * facing, -18, false, false);
					attack_phase++;
					attack_frame = 8;
					var _hitbox = hitbox_create_magnetbox(20, 0, 0.6, 0.6, 5, 4, 16, -32, 8, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					invulnerability_set(INV.superarmor, 4);
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 3;
				if (attack_frame == 3)
					anim_frame = 4;
				//Grab ledges
				if check_ledge_grab() return;
				//Drift while rising
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					hsp += 1 * stick_get_value(Lstick, DIR.horizontal);
					}
				if (facing == 1)
					{
					hsp = clamp(hsp, 1, 7);
					}
				else
					{
					hsp = clamp(hsp, -7, -1);
					}
				//Looping hitboxes
				if (attack_frame % 2 == 0)
					{
					hitbox_group_reset(1);
					var _hitbox = hitbox_create_magnetbox(10, -10, 0.6, 0.6, 1, 4, 16, -32, 8, 3, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					}
				//Final hitbox
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 5;
				
					if (vsp < 0)
						{
						speed_set(0, 8, true, true);
						}
					attack_phase++;
					attack_frame = 15;
					var _hitbox = hitbox_create_melee(10, -20, 0.4, 0.4, 3, 12, 0.7, 20, 55, 4, SHAPE.circle, 2);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Gravity
				friction_gravity(air_friction, grav, max_fall_speed);
				//Grab ledges
				if (!stick_tilted(Lstick, DIR.up) && check_ledge_grab()) return;
				//Animation
				if (attack_frame == 8)
					anim_frame = 6;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			}
		}
	//Movement
	move();


}

/* Copyright 2023 Springroll Games / Yosi */