function dspec_counter() {
	//Counter
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Animation
				anim_sprite = spr_dspec_counter;
				anim_frame = 0;
				anim_speed = 0;
				
				attack_frame = 5;
				break;
				}
			//Startup
			case 0:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					friction_gravity(ground_friction);
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 1;
				
					attack_phase++;
					attack_frame = 20;
					invulnerability_set(INV.counter, 20);
					speed_set(0, 1, true, false);
					}
				
				//Movement
				move();
				break;
				}
			//Check for attacks
			case 1:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, 2);
					}
				else
					{
					friction_gravity(air_friction, grav, 2);
					speed_set(0, 1, true, false);
					}
			
				//Animation
				if (attack_frame == 10)
					anim_frame = 2;
		
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 24;
					}
				
				//Movement
				move();
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 4;
					
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
					}
					
				if (attack_frame == 0)
					{
					attack_stop();
					}
				
				//Movement
				move();
				break;
				}
			//Counter activate
			case PHASE.counter:
				{
				var _attacking_hitbox = argument[1];
				
				//Freeze frames for both players
				self_hitlag_frame = 10;
				_attacking_hitbox.owner.self_hitlag_frame = 16;
			
				//Face the attacker
				var _face = sign(_attacking_hitbox.owner.x - x);
				if (_face != 0) then facing = _face;
			
				//Animation
				anim_frame = 5;
			
				//Next phase
				attack_phase = 3;
				attack_frame = 30;
				invulnerability_set(INV.deactivate, 36);
				speed_set(0, 0, false, false);
				
				//VFX
				var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
				_vfx.vfx_xscale = 2 * facing;
				vfx_create_action_lines(30, x, y, prng_number(0, 10), "VFX_Layer");
				vfx_create(spr_hit_counter, 1, 0, 36, x, y, 2, 0, "VFX_Layer");
				fade_value = 0;
				_attacking_hitbox.owner.fade_value = 0;
				camera_shake(10);
				break;
				}
			//Attack phase
			case 3:
				{
				//Speeds
				speed_set(0, 0, false, false);
				
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Animation
				if (attack_frame == 28)
					anim_frame = 6;
				if (attack_frame == 26)
					anim_frame = 7;
				if (attack_frame == 21)
					anim_frame = 9;
				if (attack_frame == 15)
					anim_frame = 10;
				if (attack_frame == 7)
					anim_frame = 11;
			
				//Hitbox
				if (attack_frame == 24)
					{
					anim_frame = 8;
					var _hitbox = hitbox_create_melee(36, 0, 1, 1.9, 7, 10, 1, 10, 40, 7, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					}
			
				//End attack
				if (attack_frame == 0)
					{
					attack_stop();
					}
				
				//Movement
				move();
				break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */