function dspec5() {
	//Down Special for Alex
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction, grav, max_fall_speed);
	
	//Canceling
	if (run && cancel_air_check()) then run = false;

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dspec5;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 6;
				hurtbox_anim_set(spr_hurtbox_crouch5, 0, 1, 1, 0);
				return;
				}
			//Charging -> Startup
			case 0:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
					
				//Charging
				if (attack_frame == 0)
					{
					charge++;
					if (charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)))
						{
						attack_phase++;
						attack_frame = 4;
						}
						
					if (charge % 8 == 0)
						{
						if (anim_frame == 0)
							{
							anim_frame = 1;
							}
						else
							{
							anim_frame = 0;
							}
						}
					}
				break;
				}
			//Swing 1
			case 1:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 2;
		
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 10;
					var _hitbox = hitbox_create_melee(0, -2, 0.68, 0.32, 14, 8, 1.3, 8, 75, 6, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				break;
				}
			//Swing 2
			case 2:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 5)
					anim_frame = 5;
				if (attack_frame == 2)
					anim_frame = 6;
		
				if (attack_frame == 0)
					{
					anim_frame = 7;
				
					attack_phase++;
					attack_frame = 6;
					
					
					
					var _hitbox = hitbox_create_melee(-1, 9, 0.53, 0.13, 15, 7, 1.5, 8, 45, 5, SHAPE.square, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Attack -> Endlag
			case 3:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 8;
					
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 24;
					}
				break;
				}
			//Finish
			case 4:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 9;
				if (attack_frame == 5)
					anim_frame = 10;
		
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
}
