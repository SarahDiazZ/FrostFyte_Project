function fspec_shadow_flare() {
	//Forward Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);

	//Speeds
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		aerial_drift();
		fastfall_try();
		}

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec_shadow_flare;
				anim_speed = 0;
				anim_frame = 0;
				
				if (!on_ground())
					{
					speed_set(0, -1, true, true);
					}
			
				attack_frame = 16;
				charge = 0;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 11)
					{
					b_reverse();
					}
					
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					charge++;
					if (!input_held(INPUT.special) || charge >= 25)
						{
						attack_phase++;
						attack_frame = 18;
						
						//Projectile
						var _hitbox = hitbox_create_projectile(24, 0, 0.6, 0.1, 2, 0, 0, 90, 10 + floor(charge / 3), SHAPE.square, 11, 0);
						hitbox_overlay_sprite_set(_hitbox, spr_fspec_shadow_flare_beam, 0, 0.5, 2, 0, c_white, 1, facing);
						_hitbox.knockback_state = PLAYER_STATE.flinch;
						_hitbox.hit_vfx_style = HIT_VFX.magic;
						_hitbox.hit_sfx = snd_hit_weak2;
						_hitbox.post_hit_script = fspec_shadow_flare_post_hit;
						_hitbox.custom_projectile_struct.shadow_flare_number = floor(lerp(1, 3, charge / 25));
						_hitbox.can_lock = true;
						}
					}
				break;
				}
			//Endlag
			case 1:
				{
				if (attack_frame == 14)
					anim_frame = 3;
				if (attack_frame == 7)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				}
			}
		}
	//Movement
	move();
}

/* Copyright 2023 Springroll Games / Yosi */