function fthrow4() {
	//Forward Throw
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
					
				//Move the grabbed opponent
				grab_snap_move();
				
				//Animation
				anim_sprite = spr_fthrow4;
				speed_set(0, 0, false, false);
				anim_speed = 0;
				anim_frame = 0;
				
				attack_frame = 19;
			
				grabbed_id.grab_hold_y = -2;
			
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 19);
				with(grabbed_id)
					{
					invulnerability_set(INV.superarmor, 19);
					}
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Automatically animate
				if (attack_frame % 5 == 0)
					anim_frame++;
				
				//Final hitbox
				if (attack_frame == 0)
					{
					move_x(68 * facing);
					anim_frame = 4;
					attack_phase++;
					attack_frame = 24;
					speed_set(-2 * facing, 0, true, false);
					var _hitbox = hitbox_create_targetbox(-45, -10, 1.3, 1.3, 7, 8, 0.7, 5, 40, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				
				//Animation
				if (attack_frame == 20)
					anim_frame = 5;
				if (attack_frame == 16)
					anim_frame = 6;
				if (attack_frame == 12)
					anim_frame = 7;
				if (attack_frame == 8)
					anim_frame = 8;
				if (attack_frame == 4)
					anim_frame = 9;
			
				//Finish
				if (attack_frame == 0)
					{
					if (on_ground())
						{
						attack_stop(PLAYER_STATE.idle);
						}
					else
						{
						attack_stop(PLAYER_STATE.aerial);
						}
					}
				break;
				}
			}
		}
	//Stay on the ground
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */