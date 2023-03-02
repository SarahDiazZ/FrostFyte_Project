function dash_attack4() {
	//Dash Attack
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_dash_attack4;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 7;
				return;
				}
			//Startup
			case 0:
				{
				//Friction
				friction_gravity(0.35);
				
				if (attack_frame == 3)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 3;
					
					speed_set(12 * facing, 0, false, false);
				
					var _hitbox = hitbox_create_melee(22, 12, 0.9, 0.6, 6, 10, 0.15, 4, 70, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.custom_hitstun = 40;
					_hitbox.shieldstun_scaling = 0.5;
					}
				break;
				}
			//Active
			case 1:
				{		
				//Friction
				friction_gravity(0.45);
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = attack_connected() ? 12 : 22;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Friction
				friction_gravity(0.55);
	
				//Animation
				if (attack_frame == 16)
					anim_frame = 4;
				if (attack_frame == 11)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */