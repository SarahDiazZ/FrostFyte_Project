function uthrow_combo() {
	//Upward Throw
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_uthrow_combo;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 12;
				
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 12);
			
				//Move opponent close
				grabbed_id.grab_hold_x = 10;
				grabbed_id.grab_hold_y = 15;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Move the grabbed opponent
				grab_snap_move();
				
				if (attack_frame == 7)
					{
					anim_frame = 1;
					grabbed_id.grab_hold_y = 15;
					}
				if (attack_frame == 2)
					anim_frame = 2;
				
				//Final hitbox
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 16;
					var _hitbox = hitbox_create_targetbox(0, 0, 1, 1, 3, 11, 0.5, 4, 85, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.drift_di_multiplier = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				if (attack_frame == 13)
					anim_frame = 4;
				if (attack_frame = 9)
					anim_frame = 5;
				if (attack_frame == 6)
					anim_frame = 6;
				if (attack_frame = 3)
					anim_frame = 7;
			
				//Finish
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Stay on the ground
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */