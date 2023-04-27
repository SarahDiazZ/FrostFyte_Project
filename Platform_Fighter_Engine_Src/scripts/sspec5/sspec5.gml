function sspec5() {
	//Forward Smash for Alex
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
				anim_sprite = spr_sspec5;
				anim_frame = 0;
				anim_speed = 0;
				speed_set(20 * facing, 0, false, false);
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
						
					//Animation (every 8 frames switch the sprite)
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