///Parry for character0
function parry_press0() {
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : state_phase;
	//Speeds
	friction_gravity(slide_friction);
	//Cancel in air
	if (run && !on_ground())
		{
		state_set(PLAYER_STATE.aerial);
		run = false;
		}
		
	//Transition through phases of parrying
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_parrying0;
				anim_speed = 0;
				anim_frame = 0;
				return;
				}
			case 0:
				{
				//Animation
				if (state_frame == 1)
					anim_frame = 1;
				else
					anim_frame = 0;
			
				if (state_frame == 0)
					{
					//Animation
					anim_frame = 2;
				
					//Next phase
					state_phase++;
					state_frame = parry_press_active;
					//Invulnerability
					invulnerability_set(INV.parry_press, parry_press_active + 1);
					}
				break;
				}
			case 1:
				{
				//Animation
				if (state_frame == 4)
					anim_frame = 3;
			
				if (state_frame == 0)
					{
					anim_frame = 4;
					state_phase = 3;
					state_frame = parry_press_endlag;
					}
				break;
				}
			case 3:
				{
				//Animation
				if (state_frame == 20)
					anim_frame = 4;
				if (state_frame == 10)
					anim_frame = 5;
				
				//End parry
				if (state_frame == 0)
					{
					state_phase = 0;
				
					//Back to Idle State
					state_set(PLAYER_STATE.idle);
					}
				break;
				}
			case PHASE.parry_press:
				{
				/*Parry has been triggered by a hitbox*/
				hurtbox_inv_set(hurtbox, INV.invincible, parry_press_invincible_time, false);
				if (state_frame > 14)
					anim_frame = 6;
				if (state_frame == 13)
					anim_frame = 7;
				if (state_frame == 12)
					anim_frame = 8;
				if (state_frame == 10)
					anim_frame = 9;
				if (state_frame == 8)
					anim_frame = 10;
				if (state_frame == 5)
					anim_frame = 11;
				if (state_frame == 3)
					anim_frame = 12;
				
				if (state_frame == 0)
					{
					state_phase = 3;
					state_frame = 10;
					}
				}
			default: break;
			}
		}
		
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */