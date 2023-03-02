function bthrow0() {
	//Backward Throw for character0
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
				anim_sprite = spr_bthrow0;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 10;
			
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 10);
			
				//No speed
				speed_set(0, 0, false, false);
			
				//Move the grabbed player behind
				grabbed_id.grab_hold_x = -60;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Move the grabbed opponent
				grab_snap_move();
				
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 15;
					var _hitbox = hitbox_create_melee(-32, -2, 1, 0.6, 9, 6, 1.4, 11, 145, 5, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 13)
					anim_frame = 2;
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 6)
					anim_frame = 4;
				if (attack_frame == 4)
					anim_frame = 5;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//No movement
}
/* Copyright 2023 Springroll Games / Yosi */