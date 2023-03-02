function dspec_flip_jump() {
	//Down Special
	/*
	- Press the special button during the flip to kick in a direction
	*/
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
				anim_sprite = spr_dspec_flip_jump;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 38;
				speed_set(0, 0, false, false);
				attack_cooldown_set(100);
				return;
				}
			//Flip Jump
			case 0:
				{
				friction_gravity(air_friction, 0.8, max_fall_speed);
				aerial_drift_momentum();

				//Animation
				if (attack_frame == 34)
					anim_frame = 2;
				if (attack_frame == 32)
					anim_frame = 3;
				if (attack_frame == 30)
					anim_frame = 4;
				if (attack_frame == 28)
					anim_frame = 5;
				if (attack_frame == 26)
					anim_frame = 6;
				if (attack_frame == 24)
					anim_frame = 7;
				if (attack_frame == 22)
					anim_frame = 8;
				if (attack_frame == 20)
					anim_frame = 9;
				if (attack_frame == 18)
					anim_frame = 10;
				if (attack_frame == 16)
					anim_frame = 11;
				if (attack_frame == 14)
					anim_frame = 12;
				if (attack_frame == 12)
					anim_frame = 13;
				if (attack_frame == 9)
					anim_frame = 14;
				if (attack_frame == 6)
					anim_frame = 15;
				if (attack_frame == 3)
					anim_frame = 16;
				
				//Jump
				if (attack_frame == 36)
					{
					anim_frame = 1;
					speed_set(9 * facing, -13, false, false);
					}
				
				//Kick
				if (attack_frame <= 24 && attack_frame > 0 && input_pressed(INPUT.special))
					{
					anim_frame = 17;
					attack_frame = 30;
					attack_phase = 1;
					if (stick_tilted(Lstick, DIR.horizontal))
						{
						facing = -sign(stick_get_value(Lstick, DIR.horizontal));
						}
					}
			
				//VFX
				if (attack_frame % 4 == 0)
					{
					var _vfx = vfx_create_color(anim_sprite, 0, anim_frame, 8, x, y, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					_vfx.fade = true;
					}
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Flip Kick
			case 1:
				{
				if (attack_frame >= 21)
					{
					friction_gravity(air_friction, 0.8, max_fall_speed);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					aerial_drift();
					}
			
				//Animation
				if (attack_frame == 27)
					anim_frame = 18;
				if (attack_frame == 24)
					anim_frame = 19;
				if (attack_frame == 18)
					anim_frame = 21;
				if (attack_frame == 15)
					anim_frame = 22;
				if (attack_frame == 12)
					anim_frame = 23;
				if (attack_frame == 7)
					anim_frame = 24;
				if (attack_frame == 4)
					anim_frame = 25;

				if (attack_frame == 21)
					{
					anim_frame = 20;
					speed_set(2, -6, false, false);
					var _hitbox = hitbox_create_melee(-36, 60, 0.2, 0.2, 13, 5, 1.2, 15, 235, 3, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(-20, 36, 1, 0.4, 11, 5, 0.9, 10, 235, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 65);
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					}
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */