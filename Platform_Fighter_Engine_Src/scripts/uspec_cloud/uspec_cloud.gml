function uspec_cloud() {
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
				anim_sprite = spr_uspec_cloud;
				anim_speed = 0;
				
				parry_stun_time = 60;
				attack_frame = 8;
				landing_lag = 15;
				return;
				}
			//First startup
			case 0:
				{
				aerial_drift();
				
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 25;
					
					//Initial hitbox
					var _hitbox = hitbox_create_melee(50, 0, 1.2, 0.3, 3, 13, 0, 14, 90, 1, SHAPE.square, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.is_reeling = true;
					_hitbox.custom_hitstun = 30;
					_hitbox.drift_di_multiplier = 0;
					}
				break;
				}
			//First active
			case 1:
				{
				//Animation
				if (attack_frame == 24)
					anim_frame = 3;
				if (attack_frame == 22)
					anim_frame = 4;
				if (attack_frame == 20)
					anim_frame = 5;
				if (attack_frame == 18)
					anim_frame = 6;
				if (attack_frame == 15)
					anim_frame = 7;
				if (attack_frame == 8)
					anim_frame = 8;
				
				if (attack_frame == 24)
					{
					speed_set(0, -22, false, false);
					
					//First rising hitbox
					var _hitbox = hitbox_create_melee(50, -12, 1.2, 0.7, 4, 13, 0, 4, 90, 2, SHAPE.square, 1);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.is_reeling = true;
					_hitbox.custom_hitstun = 30;
					_hitbox.drift_di_multiplier = 0;
					}
					
				if (attack_frame == 22)
					{
					//Second rising hitbox
					var _hitbox = hitbox_create_melee(50, -12, 1.2, 0.7, 4, 5, 0, 4, 90, 7, SHAPE.square, 1);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_weak];
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.is_reeling = true;
					_hitbox.custom_hitstun = 25;
					_hitbox.drift_di_multiplier = 0;
					}
				
				//Limit speed
				if (attack_frame == 15)
					{
					if (vsp < -4) then speed_set(0, -4, true, false);
					}
				
				//Ledge grab
				if (check_ledge_grab()) then return;
				
				//Ledge grab
				if (attack_frame <= 15)
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					aerial_drift();
					
					//Second part
					if (input_pressed(INPUT.special))
						{
						attack_phase = 2;
						attack_frame = 10;
						
						anim_frame = 9;
						break;
						}
					}
			
				//Finish
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//Second startup
			case 2:
				{
				friction_gravity(air_friction, grav, max_fall_speed);
				
				//Animation
				if (attack_frame == 7)
					anim_frame = 10;
				if (attack_frame == 4)
					anim_frame = 11;
				if (attack_frame == 2)
					anim_frame = 12;
				
				if (attack_frame == 0)
					{
					anim_frame = 13;
					attack_phase++;
					attack_frame = 300;
					
					speed_set(0, 20, false, false);
					
					//Falling hitbox
					var _hitbox = hitbox_create_melee(48, 14, 1.3, 0.5, 8, 12, 0.8, 8, 275, 300, SHAPE.square, 2, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.techable = false;
					}
				break;
				}
			//Second active
			case 3:
				{
				//Looping animation
				if (attack_frame % 3 == 0)
					{
					if (anim_frame == 13) then anim_frame = 14;
					else anim_frame = 13;
					}
					
				//Ledge grab
				if (check_ledge_grab()) then return;
				
				//Landing hitbox
				if (on_ground())
					{
					camera_shake(0, 11);
					
					speed_set(0, 0, false, false);
					
					attack_phase++;
					attack_frame = 30;
					anim_frame = 15;
					
					hitbox_destroy_attached_all();
					
					//Ground-only hitbox
					var _hitbox = hitbox_create_melee(30, 14, 2.3, 0.3, 5, 13, 0.5, 10, 65, 3, SHAPE.square, 3, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.custom_hitstun = 25;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					
					var _hitbox = hitbox_create_melee(46, -14, 1.3, 1.2, 5, 13, 0.5, 10, 65, 1, SHAPE.square, 3, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.custom_hitstun = 25;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//VFX
					vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					}
				
				//Finish
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//Second ground ending
			case 4:
				{
				//Animation
				if (attack_frame == 27)
					anim_frame = 16;
				if (attack_frame == 13)
					anim_frame = 17;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
		
	//Movement
	move();
}

/* Copyright 2023 Springroll Games / Yosi */