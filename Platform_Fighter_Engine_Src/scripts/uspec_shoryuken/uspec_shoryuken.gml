function uspec_shoryuken() {
	//Up Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Speeds
	friction_gravity(air_friction, grav, max_fall_speed);
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_frame = 0;
				anim_sprite = spr_uspec_shoryuken;
				anim_speed = 0;
				
				//Please note: The <uspec_shoryuken_input_passive> script must be added as a callback separately to allow motion inputs.
				
				//Input version
				if (!variable_struct_exists(custom_attack_struct, "uspec_shoryuken_input"))
					{
					custom_attack_struct.uspec_shoryuken_input = false;
					}
				
				parry_stun_time = 60;
				landing_lag = 22;
				attack_frame = 6;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 26;
					
					//Input version
					if (custom_attack_struct.uspec_shoryuken_input)
						{
						custom_attack_struct.uspec_shoryuken_input = false;
						
						invulnerability_set(INV.deactivate, 5);
						
						//Initial hitbox
						var _hitbox = hitbox_create_melee(28, 0, 0.6, 0.7, 15, 10, 1.2, 17, 85, 1, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.normal_medium];
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.is_reeling = true;
						}
					else
						{
						//Initial hitbox
						var _hitbox = hitbox_create_melee(28, 0, 0.6, 0.7, 13, 10, 1.1, 14, 80, 1, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.is_reeling = true;
						}
					}
				break;
				}
			//Active / Finish
			case 1:
				{
				//Animation
				if (attack_frame == 25)
					anim_frame = 3;
				if (attack_frame == 22)
					anim_frame = 4;
				if (attack_frame == 16)
					anim_frame = 5;
				if (attack_frame == 11)
					anim_frame = 6;
				if (attack_frame == 6)
					anim_frame = 7;
				if (attack_frame == 3)
					anim_frame = 8;
				
				if (attack_frame == 25)
					{
					speed_set(4 * facing, -19, false, false);
					
					//Late hitbox
					var _hitbox = hitbox_create_melee(14, -20, 0.6, 1.2, 7, 8, 0.9, 8, 70, 12, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				
				//Limit speed
				if (attack_frame == 15)
					{
					if (vsp < -4) then speed_set(0, -4, true, false);
					}
				
				//Ledge grab
				if (attack_frame <= 15)
					{
					if (check_ledge_grab()) then return;
					}
			
				//Finish
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