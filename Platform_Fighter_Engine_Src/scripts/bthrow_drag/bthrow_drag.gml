function bthrow_drag() {
	//Backward Throw
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
				anim_sprite = spr_bthrow_drag;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 10;
				
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 10);
			
				//No speed
				speed_set(0, 0, false, false);
			
				//Move the grabbed player behind
				grabbed_id.grab_hold_x = -50;
				grabbed_id.grab_hold_y = 2;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Move the grabbed opponent
				grab_snap_move();
				
				if (attack_frame == 5)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					speed_set(-10 * facing, 0, false, false);
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 45;
					//Drag hitbox
					var _hitbox = hitbox_create_magnetbox(-20, 14, 0.5, 0.5, 1, 1, -20, 2, 20, 14, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.none;
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				//Move the grabbed opponent
				if (attack_frame > 30)
					{
					grabbed_id.x = x + (facing * -50);
					grabbed_id.y = y + 2;
					}
				
				//Animation
				if (attack_frame == 42)
					anim_frame = 3;
				if (attack_frame == 39)
					anim_frame = 4;
				if (attack_frame == 36)
					anim_frame = 5;
				if (attack_frame == 33)
					anim_frame = 6;
				if (attack_frame == 28)
					anim_frame = 8;
				if (attack_frame == 19)
					anim_frame = 9;
				if (attack_frame == 8)
					anim_frame = 10;
				
				//Drag loops
				if (attack_frame >= 11 && attack_frame % 2 == 0)
					{
					hitbox_group_reset(0);
					}
			
				//Final hit
				if (attack_frame == 30)
					{
					speed_set(0, 0, false, false);
					anim_frame = 7;
					var _hitbox = hitbox_create_melee(-22, 0, 1, 0.7, 9, 12, 0.6, 3, 120, 7, SHAPE.circle, 1);
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 0.8;
					}
			
				//Cancels
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