function uthrow_jump() {
	//Upward Throw
	/*
	- Jumps up and then throws opponents down
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions
	friction_gravity(air_friction, grav, 2);
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_uthrow_jump;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 20;
			
				//Jump upwards
				speed_set(0, -12, false, false);
				grabbed_id.grab_hold_x = 24;
				return;
				}
			//Throw
			case 0:
				{
				//Move the grabbed opponent
				grab_snap_move();
				
				//Animation
				if (attack_frame == 15)
					anim_frame = 1;
				if (attack_frame == 10)
					{
					anim_frame = 2;
					grabbed_id.grab_hold_y = -16;
					}
				if (attack_frame == 5)
					anim_frame = 3;
			
				if (attack_frame == 0)
					{
					anim_frame = 4;
				
					attack_phase++;
					attack_frame = 8;
					speed_set(0, 1, false, false);
					
					//Throw downwards
					var _hitbox = hitbox_create_targetbox(0, 0, 1, 1, 9, 11, 0.2, 11, 270, 1, SHAPE.square, 0, grabbed_id, FLIPPER.fixed);
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.force_reeling = true;
					}
				break;
				}
			//Finish
			case 1:
				{
				aerial_drift();
				fastfall_try();
				
				//Animation
				if (attack_frame == 7)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
				if (attack_frame == 3)
					anim_frame = 7;
				if (attack_frame == 1)
					anim_frame = 8;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */