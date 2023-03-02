function fthrow0() {
	//Forward Throw for character0
	/*
	- Jumps up with the opponent, then slams them into the ground
	- Press the attack button to flip kick off the opponent. If you are still rising, the kick will be stronger
	- If you fall for enough time, the flip kick will be triggered automatically
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
				anim_sprite = spr_fthrow0;
				anim_speed = 0;
				anim_frame = 0;
				
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 10);
			
				//Jump up in an arc
				speed_set(4 * facing, -12, false, false);
				attack_phase = 0;
				attack_frame = 60;
				return;
				}
			//Jumping
			case 0:
				{
				//Animation
				if (vsp < -10)
					anim_frame = 1;
				else if (vsp < -5)
					anim_frame = 2;
				else if (vsp < 0)
					anim_frame = 3;
				else if (vsp < 5)
					anim_frame = 4;
				else if (vsp < 10)
					anim_frame = 5;
				
				//Friction and gravity
				friction_gravity(air_friction, grav, 30);

				//Cancel on ground
				if (on_ground())
					{
					//Animation
					anim_frame = 11;
				
					var _hitbox = hitbox_create_melee(32, 0, 0.4, 0.4, 12, 13, 0.6, 10, 80, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_explosion2;
					attack_frame = 10;
					attack_phase = 1;
					break;
					}
				
				//Kick attack
				//Manual cancel or automatically cancel after falling a certain amount
				if (input_pressed(INPUT.attack) || attack_frame == 0)
					{
					//Animation
					anim_frame = 6;
				
					if (vsp <= 0)
						{
						var _hitbox = hitbox_create_targetbox(24, 24, 2, 2, 9, 9, 0.7, 21, 40, 1, SHAPE.circle, 0, grabbed_id);
						_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
						_hitbox.hit_sfx = snd_hit_strong;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						}
					else
						{
						var _hitbox = hitbox_create_targetbox(24, 24, 2, 2, 9, 8, 0.6, 18, 55, 1, SHAPE.circle, 0, grabbed_id);
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						}
					speed_set(-5 * facing, -9, false, false);
					attack_frame = 15;
					attack_phase = 2;
					break;
					}
					
				//Movement
				move_hit_platforms();
				
				//Hold the grabbed player
				with(grabbed_id)
					{
					//Manually move the target
					grab_hold_enable = false;
					speed_set(0, 0, false, false);
					x = other.x + (16 * other.facing);
					y = other.y;
					}
				break;
				}
			//Grounded Endlag
			case 1:
				{
				friction_gravity(ground_friction);
				
				//Animation
				if (attack_frame == 8)
					anim_frame = 12;
				if (attack_frame == 6)
					anim_frame = 13;
				if (attack_frame == 3)
					anim_frame = 14;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
					
				//Movement
				move_grounded();
				break;
				}
			//Manual Cancel Endlag (Flip)
			case 2:
				{
				friction_gravity(air_friction, grav);
				
				//Animation
				if (attack_frame == 13)
					anim_frame = 7;
				if (attack_frame == 10)
					anim_frame = 8;
				if (attack_frame == 6)
					anim_frame = 9;
				if (attack_frame == 3)
					anim_frame = 10;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
					
				//Movement
				move();
				break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */