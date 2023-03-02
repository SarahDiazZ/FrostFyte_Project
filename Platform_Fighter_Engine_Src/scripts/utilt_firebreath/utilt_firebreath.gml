function utilt_firebreath() {
	//Upward Tilt
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
				anim_sprite = spr_utilt_firebreath;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 10;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(24, 4, 0.3, 0.6, 2, 9, 0, 3, 65, 1, SHAPE.square, 0, FLIPPER.toward_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					var _hitbox = hitbox_create_melee(14, -24, 0.6, 0.6, 2, 6, 0, 3, 90, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.magic;
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 7)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_magnetbox(22, -44, 0.8, 0.4, 3, 3, 11, -22, 10, 4, SHAPE.rotation, 1);
					hitbox_sprite_angle_set(_hitbox, 60);
					_hitbox.hit_vfx_style = HIT_VFX.magic;
					}
				
				if (attack_frame == 4)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(22, -44, 0.9, 0.4, 3, 5, 0.1, 3, 55, 4, SHAPE.rotation, 2);
					hitbox_sprite_angle_set(_hitbox, 60);
					_hitbox.hit_vfx_style = HIT_VFX.magic;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 6;
					var _hitbox = hitbox_create_melee(22, -44, 1.1, 0.6, 5, 8, 1, 11, 60, 4, SHAPE.rotation, 3);
					hitbox_sprite_angle_set(_hitbox, 60);
					_hitbox.hit_vfx_style = [HIT_VFX.spin, HIT_VFX.magic];
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 15;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 13)
					anim_frame = 7;
				if (attack_frame == 9)
					anim_frame = 8;
				if (attack_frame = 5)
					anim_frame = 9;

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