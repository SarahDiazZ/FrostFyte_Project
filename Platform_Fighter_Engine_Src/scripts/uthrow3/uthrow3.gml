function uthrow3() {
	//Upward Throw for character3
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
				anim_sprite = spr_uthrow3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 15;
			
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 15);
			
				//Move opponent above
				grabbed_id.grab_hold_x = 0;
				grabbed_id.grab_hold_y = -10;
				
				return;
				}
			//Startup
			case 0:
				{
				//Grab
				grab_snap_move();
				
				//Animation
				if (attack_frame == 10)
					anim_frame = 1;
				if (attack_frame == 5)
					anim_frame = 2;
				
				//Final hitbox
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 10;
					var _hitbox = hitbox_create_targetbox(0, -45, 1, 1, 5, 15.5, 0.7, 4, 90, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.custom_hitstun = 37;
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame = 5)
					anim_frame = 5;
				if (attack_frame = 3)
					anim_frame = 6;
			
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