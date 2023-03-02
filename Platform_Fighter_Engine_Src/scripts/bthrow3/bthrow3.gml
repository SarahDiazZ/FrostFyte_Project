function bthrow3() {
	//Backward Throw for character3
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction, grav, max_fall_speed);
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_bthrow3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 20;
			
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 20);
			
				//Move opponent above
				grabbed_id.x = x + (facing * -6);
				grabbed_id.y = y - 35;
				
				hurtbox_anim_match(spr_bthrow3_hurtbox);
				return;
				}
			//Startup
			case 0:
				{
				speed_set(-4 * facing, 0, false, false);
				
				//Animation
				if (attack_frame == 17)
					anim_frame = 1;
				if (attack_frame == 14)
					anim_frame = 2;
				if (attack_frame == 11)
					anim_frame = 3;
				if (attack_frame == 9)
					anim_frame = 4;
				if (attack_frame == 6)
					anim_frame = 5;
				if (attack_frame == 4)
					anim_frame = 6;
				if (attack_frame == 2)
					anim_frame = 7;
					
				//Hold the opponent
				if (anim_frame == 1)
					{
					grabbed_id.x = x + (facing * -10);
					grabbed_id.y = y - 44;
					}
				else if (anim_frame == 2 || anim_frame == 3 || anim_frame == 4)
					{
					grabbed_id.x = x + (facing * -15);
					grabbed_id.y = y - 44;
					}
				else if (anim_frame == 5)
					{
					grabbed_id.x = x + (facing * -32);
					grabbed_id.y = y - 32;
					}
				else if (anim_frame == 6)
					{
					grabbed_id.x = x + (facing * -32);
					grabbed_id.y = y - 6;
					}
				else if (anim_frame == 7)
					{
					grabbed_id.x = x + (facing * -38);
					grabbed_id.y = y - 4;
					}
				
				//Final hitbox
				if (attack_frame == 0)
					{
					anim_frame = 8;
					attack_phase++;
					attack_frame = 15;
					var _hitbox = hitbox_create_targetbox(-32, 0, 1, 1, 14, 6.2, 1, 10, 145, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(-70, 5, 1.5, 0.8, 10, 7, 0.7, 7, 135, 4, SHAPE.square, 0, grabbed_id);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 11)
					anim_frame = 9;
				if (attack_frame = 7)
					anim_frame = 10;
				if (attack_frame = 3)
					anim_frame = 11;
			
				//Finish
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
		}
	//Stay on the ground
	move_grounded();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match(spr_bthrow3_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */