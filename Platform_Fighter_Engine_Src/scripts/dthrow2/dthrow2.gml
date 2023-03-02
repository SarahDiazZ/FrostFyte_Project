function dthrow2() {
	//Downward Throw for character2
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
				anim_sprite = spr_dthrow2;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 10;
				
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 10);
			
				//No speed
				speed_set(0, 0, false, false);
			
				//Move the grabbed player below
				grabbed_id.grab_hold_x = 16;
				grabbed_id.grab_hold_y = 32;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Move the grabbed opponent
				grab_snap_move();
				
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 15;
					var _hitbox = hitbox_create_targetbox(10, 16, 0.4, 0.4, 5, 5, 0, 2, 270, 1, SHAPE.circle, 0, grabbed_id);
					_hitbox.knockback_state = PLAYER_STATE.is_grabbed;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Move the grabbed opponent
				grab_snap_move();
				
				//Multihits
				if (attack_frame % 2 == 0 && attack_frame != 0)
					{
					anim_frame++;
				
					hitbox_group_reset_all();
					var _hitbox = hitbox_create_targetbox(10, 16, 0.4, 0.4, 1, 5, 0, 3, 270 + (attack_frame * 100), 1, SHAPE.circle, 0, grabbed_id);
					_hitbox.knockback_state = PLAYER_STATE.is_grabbed;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hitlag_scaling = 0;
					_hitbox.techable = false;
					_hitbox.asdi_multiplier = 0;
					}
				//Final Blow
				if (attack_frame == 0)
					{
					anim_frame = 10;
				
					attack_phase++;
					attack_frame = 15;
					var _hitbox = hitbox_create_melee(10, 16, 0.4, 0.4, 3, 14, 0.3, 7, 75, 1, SHAPE.circle, 1);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 0.75;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Endlag -> Finish
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 11;
				if (attack_frame == 8)
					anim_frame = 12;
				if (attack_frame == 4)
					anim_frame = 13;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				}
			}
		}
	//No movement
}
/* Copyright 2023 Springroll Games / Yosi */