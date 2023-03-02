function getup_attack3() {
	//Getup Attack for character3
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
				//Animation
				anim_sprite = spr_getup_attack3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 18;
				invulnerability_set(INV.invincible, 23);
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 26;
					
					//First Hit
					var _hitbox = hitbox_create_melee(-40, 20, 0.8, 0.6, 5, 9, 0.25, 4, 35, 2, SHAPE.square, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.custom_hitstun = 26;
					}
				break;
				}
			//Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 25)
					anim_frame = 4;
				if (attack_frame == 22)
					anim_frame = 6;
				if (attack_frame == 15)
					anim_frame = 7;
				if (attack_frame == 8)
					anim_frame = 8;
				
				if (attack_frame == 24)
					{
					anim_frame = 5;
					
					//Second Hit
					var _hitbox = hitbox_create_melee(16, 20, 1.3, 0.6, 5, 9, 0.25, 4, 35, 2, SHAPE.square, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.custom_hitstun = 24;
					}
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */