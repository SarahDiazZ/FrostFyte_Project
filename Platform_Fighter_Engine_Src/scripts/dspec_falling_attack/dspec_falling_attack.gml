function dspec_falling_attack() {
	//Down Special
	/*
	- Falls quickly and spikes opponents
	- The grounded version jumps up into the air first
	- Has two hitboxes upon hitting the ground - a shockwave hitbox that only hits grounded opponents, and a direct hitbox that launches close opponents
	- You can jump cancel the fall, provided you have midair jumps left, after hitting an opponent or after enough time passes
	- Hold the button at the start to perform a super jump instead
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
				anim_sprite = spr_dspec_falling_attack;
				anim_frame = 0;
				anim_speed = 0;
			
				//Ground v.s. Air startup
				if (!on_ground())
					{
					attack_frame = 18;
					attack_phase = 0;
					speed_set(0, 0, true, false);
					}
				else
					{
					speed_set(4 * facing, -8.5, false, false);
					attack_frame = 18;
					attack_phase = 3;
					}
					
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Animation
				if (attack_frame == 12)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 3)
					anim_frame = 3;
			
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 90;
					
					//Spike hitbox
					var _hitbox = hitbox_create_melee(16, 32, 0.6, 0.6, 6, 7, 0.4, 9, 290, 90, SHAPE.circle, 0);
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					_hitbox.di_angle = 0;
					_hitbox.drift_di_multiplier = 0;
					_hitbox.asdi_multiplier = 0;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					
					//Hitbox to connect with grounded opponents
					var _hitbox = hitbox_create_melee(16, 32, 0.6, 0.6, 6, 7, 0.4, 9, 0, 90, SHAPE.circle, 0);
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.flinch;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation - every 2 frames
				if (attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 8)
						anim_frame = 4;
					}
				
				//Wall Jump Cancel
				if (check_wall_jump())
					{
					attack_stop_preserve_state();
					return;
					}
			
				//Speed Values
				speed_set(6 * facing, 20, false, false);
			
				//Hitting the ground causes a ground pound
				if (on_ground())
					{
					anim_frame = 9;
					
					//Cancel movement
					speed_set(0, 0, true, false);
					
					//Destroy the falling hitbox
					hitbox_destroy_attached_all();
					
					//EX version
					if (ex_move_is_activated())
						{
						camera_shake(1, 10);
						
						//Landing hitbox
						var _hitbox = hitbox_create_melee(8, 12, 0.6, 0.4, 4, 13, 0.9, 20, 55, 7, SHAPE.square, 1, FLIPPER.from_player_center_horizontal);
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.hit_vfx_style = [HIT_VFX.lines, HIT_VFX.normal_strong, HIT_VFX.emphasis];
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						
						//Shockwave
						var _hitbox = hitbox_create_melee(0, 0, 20, 20, 4, 13, 0.9, 20, 55, 3, SHAPE.circle, 1, FLIPPER.from_player_center_horizontal);
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.emphasis];
						_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
						}
					else
						{
						camera_shake(0, 6);
						
						//Landing hitbox
						var _hitbox = hitbox_create_melee(8, 12, 0.6, 0.4, 4, 13, 0.4, 17, 55, 7, SHAPE.square, 1);
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.hit_vfx_style = [HIT_VFX.lines, HIT_VFX.normal_strong];
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.hitstun_scaling = 0.75;
						_hitbox.shieldstun_scaling = 0.1;
						
						//Shockwave
						var _hitbox = hitbox_create_melee(13, 20, 3.4, 0.3, 1, 11, 0.3, 12, 90, 3, SHAPE.square, 1);
						_hitbox.hit_sfx = snd_hit_weak2;
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						_hitbox.custom_hitstun = 35;
						_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
						_hitbox.shieldstun_scaling = 0;
						}
					attack_phase = 2;
					attack_frame = 30;
					run = false;
					}
					
				//Jump Cancel on hit or after enough time
				if (run && (attack_connected() || attack_frame <= 80) && cancel_jump_check()) return;
				
				//Normal ending
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//Ground pound version
			case 2:
				{
				//Friction / Gravity
				friction_gravity(ground_friction, grav, max_fall_speed);
			
				//Enable ledge cancel
				if (cancel_air_check()) return;
				
				//Animation
				if (attack_frame == 27)
					anim_frame = 10;
				if (attack_frame == 23)
					anim_frame = 11;
				if (attack_frame == 16)
					anim_frame = 12;
				if (attack_frame == 8)
					anim_frame = 13;
		
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			//Alternate on-ground version startup.
			case 3:
				{
				//EX
				ex_move_allow(1);
				
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
				if (attack_frame == 0)
					{
					attack_phase = 0;
					speed_set(0, 0, false, false);
					attack_frame = 3;
					}
				break;
				}
			}
		}
	//Movement
	move_hit_platforms();
}
/* Copyright 2023 Springroll Games / Yosi */