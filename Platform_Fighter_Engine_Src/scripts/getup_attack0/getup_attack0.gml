function getup_attack0() {
	//Getup Attack for character0
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
				anim_sprite = spr_getup_attack0;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 18;
				invulnerability_set(INV.invincible, 20);
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
					attack_frame = 24;
					var _hitbox = hitbox_create_melee(0, 15, 1.4, 0.3, 5, 9, 0.25, 4, 35, 2, SHAPE.square, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.custom_hitstun = 24;
					}
				break;
				}
			//Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 22)
					anim_frame = 4;
				if (attack_frame == 15)
					anim_frame = 5;
				if (attack_frame == 7)
					anim_frame = 6;
					
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