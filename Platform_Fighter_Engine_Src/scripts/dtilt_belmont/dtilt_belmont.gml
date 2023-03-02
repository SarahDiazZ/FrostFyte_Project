function dtilt_belmont() {
	//Down Tilt for character0
	/*
	- Press the attack button during the slide to do the jump kick
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		}
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dtilt_belmont;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 6;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Cancel in the air
				if (cancel_air_check()) then return;
				
				if (attack_frame == 0)
					{
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 18;
					speed_set(12 * facing, 0, false, false);
					
					//Ledge hitbox
					var _hitbox = hitbox_create_melee(10, 28, 0.5, 0.2, 5, 10, 0.6, 8, 75, 4, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_restriction = HIT_RESTRICTION.ledge_only;
					
					//Early hit
					var _hitbox = hitbox_create_melee(10, 18, 0.5, 0.2, 5, 10, 0.6, 8, 75, 4, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.shieldstun_scaling = 0.1;
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
				//Movement
				move_grounded();
				break;
				}
			//Active
			case 1:
				{
				//Cancel in the air
				if (cancel_air_check()) then return;
				
				//Animation
				if (attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 4)
						{
						anim_frame = 1;
						}
					}
				
				if (attack_frame == 15)
					{
					//Late hit
					var _hitbox = hitbox_create_melee(10, 18, 0.5, 0.2, 4, 7, 0.45, 6, 75, 13, SHAPE.square, 0);
					_hitbox.shieldstun_scaling = 0.1;
					}
					
				//Second part
				if (attack_frame < 12 && input_pressed(INPUT.attack))
					{
					anim_frame = 8;
				
					attack_phase = 3;
					attack_frame = 40;
					speed_set(10 * facing, -7, false, false);
					hitbox_destroy_attached_all();
					}
				else if (attack_frame == 0)
					{
					anim_frame = 5;
				
					attack_phase++;
					//Whiff lag
					attack_frame = attack_connected() ? 4 : 17;
					}
				//Movement
				move_grounded();
				break;
				}
			//Grounded finish
			case 2:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame++;
				if (attack_frame == 10)
					anim_frame++;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.crouching);
					run = false;
					}
				//Movement
				move_grounded();
				break;
				}
			//Aerial active
			case 3:
				{
				if (attack_frame == 38)
					{
					anim_frame = 9;
				
					//Second early hit
					var _hitbox = hitbox_create_melee(10, 4, 0.5, 0.4, 5, 8, 0.8, 9, 45, 3, SHAPE.circle, 1);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.shieldstun_scaling = 0.1;
					}
				if (attack_frame == 36)
					{
					anim_frame = 10;
					
					//Second late hit
					var _hitbox = hitbox_create_melee(10, 6, 0.5, 0.4, 4, 7, 0.6, 6, 45, 12, SHAPE.circle, 1);
					_hitbox.shieldstun_scaling = 0.1;
					}
				
				//Animation
				if (attack_frame == 32)
					anim_frame = 11;
				if (attack_frame == 28)
					anim_frame = 12;
				if (attack_frame == 24)
					anim_frame = 13;
				if (attack_frame == 18)
					anim_frame = 14;
				if (attack_frame == 12)
					anim_frame = 15;
				if (attack_frame == 6)
					anim_frame = 16;
					
				//Slow down if you hit a shield
				if (attack_connected(true, true))
					{
					if (abs(hsp) > 5)
						{
						speed_set(sign(hsp) * 5, 0, false, true);
						}
					}
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					run = false;
					}
				//Movement
				move();
				break;
				}
			}
		}
	
	//Hurtbox matching
	if (run)
		{
		hurtbox_anim_set(hurtbox_crouch_sprite, 0, facing, 1, 0);
		}
}
/* Copyright 2023 Springroll Games / Yosi */