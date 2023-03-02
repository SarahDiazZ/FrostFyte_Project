function ledge_attack3() {
	//Ledge Attack for character3
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
				anim_sprite = spr_ledge_attack3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 3;
				invulnerability_set(INV.invincible, 10);
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 0)
					{
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 24;
					var _hitbox = hitbox_create_melee(24, 18, 1.2, 0.4, 7, 9, 0.25, 4, 35, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.custom_hitstun = 24;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 21)
					anim_frame = 2;
				if (attack_frame == 16)
					anim_frame = 3;
				if (attack_frame == 10)
					anim_frame = 4;
				if (attack_frame == 5)
					anim_frame = 5;
			
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