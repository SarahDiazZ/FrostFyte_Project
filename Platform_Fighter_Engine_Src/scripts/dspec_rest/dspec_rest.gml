function dspec_rest() {
	//Down Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		}
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dspec_rest;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 1;
				facing = 1;
				invulnerability_set(INV.invincible, 3);
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 36;
					var _hitbox = hitbox_create_melee(0, 0, 0.3, 0.3, 25, 6, 2, 25, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.emphasis];
					_hitbox.hit_sfx = snd_hit_explosion4;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 35)
					anim_frame = 1;
				if (attack_frame < 30)
					{
					if (attack_frame % 10 == 0)
						{
						anim_frame++;
						if (anim_frame > 5)
							anim_frame = 2;
						}
					}

				if (run && attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 100;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame % 10 == 0)
					{
					anim_frame++;
					if (anim_frame > 5)
						anim_frame = 2;
					}
			
				if (attack_frame == 0)
					{
					if (on_ground())
						{
						attack_stop(PLAYER_STATE.idle);
						}
					else
						{
						attack_stop(PLAYER_STATE.aerial);
						}
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */