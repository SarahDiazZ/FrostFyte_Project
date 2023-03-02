function pummel4() {
	//Pummel for character4
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_pummel4;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 1;
				return;
				}
			//Pummel Startup
			case 0:
				{
				if (attack_frame == 0)
					{
					speed_set(3 * facing, 0, true, false);
					anim_frame = 1;
					attack_phase++;
					attack_frame = 6;
					var _hitbox = hitbox_create_targetbox(45, 0, 1, 1, 1, 5, 0, 4, 355, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.knockback_state = PLAYER_STATE.is_grabbed;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					}
				break;
				}
			//Pummel Finish
			case 1:
				{
				if (attack_frame == 5)
					anim_frame = 2;
				if (attack_frame == 3)
					anim_frame = 3;
				if (attack_frame == 1)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					var _grab_frame = state_frame;
					attack_stop(PLAYER_STATE.grabbing);
					state_frame = _grab_frame;
					//No need to reset the control stick after a pummel
					throw_stick_has_reset = true;
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
	
	//Move the grabbed opponent
	grab_snap_move();
}
/* Copyright 2023 Springroll Games / Yosi */