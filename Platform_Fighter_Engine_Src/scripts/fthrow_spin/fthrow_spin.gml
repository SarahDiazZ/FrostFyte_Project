function fthrow_spin() {
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
				//Animation
				anim_sprite = spr_fthrow_spin;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 33;
			
				grabbed_id.grab_hold_y = -2;
			
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 34);
				with(grabbed_id)
					{
					invulnerability_set(INV.superarmor, 33);
					}
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Automatically animate
				if (attack_frame % 3 == 0)
					anim_frame++;
			
				//Move to front at halfway point
				if (attack_frame == 16)
					{
					with(grabbed_id)
						{
						player_move_to_front();
						}
					}
				
				//Change facing during spin
				if (attack_frame == 22 || attack_frame == 7)
					{
					with(grabbed_id)
						{
						facing *= -1;
						}
					}
			
				//Spin around player
				grabbed_id.x = x + floor(facing * (dcos((attack_frame / 33) * 360) * 50));
				grabbed_id.y = y - 2;
				
				//Move the grabbed opponent
				grab_snap_move();
				
				//Final hitbox
				if (attack_frame == 0)
					{
					anim_frame = 11;
					attack_phase++;
					attack_frame = 18;
					speed_set(2 * facing, 0, true, false);
					var _hitbox = hitbox_create_targetbox(45, 0, 1, 1, 6, 10, 0.55, 5, 45, 1, SHAPE.square, 0, grabbed_id);
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
				player_move_to_back();
				
				//Animation
				if (attack_frame == 17)
					anim_frame = 12;
				if (attack_frame == 15)
					anim_frame = 13;
				if (attack_frame == 12)
					anim_frame = 14;
				if (attack_frame == 9)
					anim_frame = 15;
				if (attack_frame == 6)
					anim_frame = 16;
				if (attack_frame == 3)
					anim_frame = 17;
			
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