function bthrow1() {
	//Backward Throw for character1
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
				anim_sprite = spr_bthrow1;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 25;
				
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 25);
			
				//No speed
				speed_set(0, 0, false, false);
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 23)
					anim_frame = 1;
				if (attack_frame == 20)
					anim_frame = 2;
					
				if (attack_frame == 17)
					{
					anim_frame = 3;
					grabbed_id.x = x + (facing * 18);
					grabbed_id.y = y + -3;
					}
				if (attack_frame == 13)
					{
					anim_frame = 4;
					grabbed_id.x = x + (facing * -23);
					grabbed_id.y = y + 4;
					}
				if (attack_frame == 9)
					{
					anim_frame = 5;
					grabbed_id.x = x + (facing * -48);
					grabbed_id.y = y;
					}
				if (attack_frame == 6)
					{
					anim_frame = 6;
					grabbed_id.x = x + (facing * -64);
					grabbed_id.y = y + -18;
					}
				if (attack_frame == 3)
					{
					anim_frame = 7;
					grabbed_id.x = x + (facing * -81);
					grabbed_id.y = y + -38;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 8;
					grabbed_id.x = x + (facing * -77);
					grabbed_id.y = y + -95;
					attack_phase++;
					attack_frame = 15;
					var _hitbox = hitbox_create_melee(-75, -60, 0.8, 2, 5, 4, 0.8, 1, 125, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.electric;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.extra_hitlag = 22;
					_hitbox.custom_hitstun = 34;
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 9;
				if (attack_frame == 9)
					anim_frame = 10;
				if (attack_frame == 6)
					anim_frame = 11;
				if (attack_frame == 3)
					anim_frame = 12;
					
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