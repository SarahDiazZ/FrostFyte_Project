function jab_chrom() {
	//Jab
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
				anim_sprite = spr_jab_chrom;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 5;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 3)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 6;
					var _hitbox = hitbox_create_melee(16, 20, 1, 0.4, 7, 9, 0.15, 4, 55, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.di_angle = 7;
					_hitbox.hitstun_scaling = 3.5;
					_hitbox.can_be_parried = false;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 5)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(34, -12, 1, 0.4, 7, 9, 0.15, 4, 55, 2, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 25);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.di_angle = 7;
					_hitbox.hitstun_scaling = 3.5;
					_hitbox.can_be_parried = false;
					}
				
				if (attack_frame == 3)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					anim_frame = 5;
					attack_phase++;
					
					//Whiff lag
					attack_frame = attack_connected() ? 9 :  20;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Dash cancel
				if (attack_connected() && cancel_dash_check())
					{
					return;
					}
				
				if (attack_frame == 13)
					anim_frame = 6;
				if (attack_frame == 6)
					anim_frame = 7;
			
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