function fthrow3() {
	//Forward Throw for character3
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
				anim_sprite = spr_fthrow3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 20;
			
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 20);
			
				//Move opponent into position
				grabbed_id.x = x + (facing * -35);
				grabbed_id.y = y + 12;
				
				hurtbox_anim_match();
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 17)
					anim_frame = 1;
				if (attack_frame == 14)
					anim_frame = 2;
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 6)
					anim_frame = 4;
				if (attack_frame == 4)
					anim_frame = 5;
				if (attack_frame == 2)
					anim_frame = 6;
				if (attack_frame == 0)
					anim_frame = 7;
					
				//Hold the opponent
				if (anim_frame == 1)
					{
					grabbed_id.x = x + (facing * -80);
					grabbed_id.y = y + 12;
					}
				else if (anim_frame == 2)
					{
					grabbed_id.x = x + (facing * -118);
					grabbed_id.y = y + 13;
					}
				else if (anim_frame == 3)
					{
					grabbed_id.x = x + (facing * -118);
					grabbed_id.y = y + 10;
					}
				else if (anim_frame == 4)
					{
					grabbed_id.x = x + (facing * -114);
					grabbed_id.y = y - 20;
					}
				else if (anim_frame == 5)
					{
					grabbed_id.x = x + (facing * -90);
					grabbed_id.y = y - 70;
					}
				else if (anim_frame == 6)
					{
					grabbed_id.x = x + (facing * -54);
					grabbed_id.y = y - 108;
					}
				else if (anim_frame == 7)
					{
					grabbed_id.x = x + (facing * 20);
					grabbed_id.y = y - 130;
					}
				
				//Final hitbox
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 20;
					var _hitbox = hitbox_create_targetbox(20, -130, 1, 1, 4, 10, 0.9, 1, 25, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.hit_vfx_style = HIT_VFX.none;
					_hitbox.hit_sfx = -1;
					_hitbox.custom_hitstun = 30;
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 9;
				if (attack_frame = 16)
					anim_frame = 10;
				if (attack_frame = 12)
					anim_frame = 11;
				if (attack_frame = 8)
					anim_frame = 12;
				if (attack_frame = 4)
					anim_frame = 13;
			
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
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */