function dspec_dizzy() {
	//Down Special
	/*
	- Any opponents it hits will become dizzy
	*/
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
				anim_sprite = spr_dspec_shine;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 2;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 30;
				
					//Hitboxes
					var _hitbox = hitbox_create_melee(0, 0, 0.7, 0.7, 10, 0, 0, 20, 90, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.explosion;
					var _hitbox = hitbox_create_detectbox(0, 0, 0.7, 0.7, 3, SHAPE.circle, 1);
					}
				break;
				}
			//Active / Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 3;
				if (attack_frame == 10)
					anim_frame = 4;
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Detection
			case PHASE.detection:
				{
				var _hit = argument[1];
				if (!object_is(_hit.object_index, obj_player)) then return;
				if (attack_connected())
					{
					with(_hit)
						{
						state_set(PLAYER_STATE.shield_break);
						state_frame = 240;
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