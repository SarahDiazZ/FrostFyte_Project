function nspec_homing_attack() {
	//Neutral Special
	/*
	- It finds the nearest in a certain radius during the charge up, and then attacks toward that player
	- The targeted player will be frozen in place during the attack
	- If no target is found, the attacker will be left helpless
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
				anim_sprite = spr_nspec_homing_attack;
				anim_frame = 0;
				anim_speed = 0;
		
				landing_lag = 20;
				attack_frame = 30;
				callback_add(callback_draw_end, nspec_homing_attack_draw);
				custom_attack_struct.homing_attack_found_target = false;
				custom_ids_struct.homing_attack_target = noone;
				speed_set(0, -1, false, false);
				
				hurtbox_anim_match(spr_nspec_homing_attack_hurtbox);
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Attack
			case 0:
				{
				//EX
				ex_move_allow(2);
				
				//Friction / No Gravity
				if (on_ground())
					{
					friction_gravity(ground_friction, 0, 0);
					}
				else
					{
					friction_gravity(air_friction, 0, 0);
					}
					
				//Animation
				if (attack_frame == 26)
					anim_frame = 1;
				if (attack_frame == 22)
					anim_frame = 2;
				if (attack_frame == 18)
					anim_frame = 3;
				if (attack_frame == 14)
					anim_frame = 4;
				if (attack_frame == 10)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
					
				//Find nearest opponent
				var _nearest = find_nearest_player(x, y, 270, player_team);
				if (_nearest != noone)
					{
					//A target has been found!
					custom_attack_struct.homing_attack_found_target = true;
					custom_ids_struct.homing_attack_target = _nearest;
					}
					
				//Face the opponent and set angle (even while charging)
				var _target = custom_ids_struct.homing_attack_target;
				if (_target != noone && custom_attack_struct.homing_attack_found_target)
					{
					if (_target.x >= x) then facing = 1;
					else facing = -1;
					var _angle = point_direction(x, y, _target.x, _target.y);
					anim_angle = facing == 1 ? _angle : _angle - 180;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
					
					//Only attack if a target has been found, and the target still exists
					if (_target != noone && custom_attack_struct.homing_attack_found_target)
						{
						//Freeze the target if they are close enough
						if (point_distance(x, y, _target.x, _target.y) <= 270)
							{
							_target.self_hitlag_frame = 6;
							}
						
						//Set speed
						var _spd = 45;
						speed_set(lengthdir_x(_spd, _angle), lengthdir_y(_spd, _angle), false, false);
						
						//Hitbox
						var _hitbox = hitbox_create_melee(0, 0, 0.8, 0.2, 4, 8, 0.7, 9, 45, 6, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, anim_angle, true);
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						
						//Cooldown
						attack_cooldown_set(60);
						
						attack_phase++;
						attack_frame = 6;
						}
					else
						{
						attack_stop(PLAYER_STATE.helpless);
						run = false;
						break;
						}
					}
					
				//EX version
				if (ex_move_is_activated() && attack_frame == 18)
					{
					//Only attack if a target has been found, and the target still exists
					if (_target != noone && custom_attack_struct.homing_attack_found_target)
						{
						//Freeze the target if they are close enough
						if (point_distance(x, y, _target.x, _target.y) <= 360)
							{
							_target.self_hitlag_frame = 6;
							}
						
						//Teleport to opponent
						with(custom_ids_struct.homing_attack_target)
							{
							other.x = round(x);
							other.y = round(y);
							speed_set(hsp / 3, vsp / 3, false, false);
							}
						
						speed_set(0, -6, false, false);
						
						//Cooldown
						attack_cooldown_set(60);
						
						attack_stop();
						return;
						}
					else
						{
						attack_stop(PLAYER_STATE.helpless);
						run = false;
						break;
						}
					}
				break;
				}
			//Attack -> Endlag
			case 1:
				{
				//Cancel on the ground
				if (cancel_ground_check()) 
					{
					speed_set(hsp / 3, 0, false, false);
					return;
					}
				
				//Animation
				if (attack_frame == 4)
					anim_frame = 8;
				if (attack_frame == 3)
					anim_frame = 9;
				if (attack_frame == 2)
					anim_frame = 10;
				if (attack_frame == 1)
					anim_frame = 11;
				
				//Ending - when the attack frame counts down, or when the attack is blocked
				if (attack_frame == 0 || attack_connected(true, true))
					{
					//Slow down
					speed_set(hsp / 4, vsp / 4, false, false);

					anim_frame = 12;
					
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Endlag -> Finish
			case 2:
				{
				//Friction / Gravity
				friction_gravity(air_friction, grav, max_fall_speed);
				
				//Cancel on the ground
				if (cancel_ground_check())
					{
					return;
					}
					
				//Animation
				if (attack_frame == 17)
					anim_frame = 13;
				if (attack_frame == 8)
					anim_frame = 14;
				
				if (attack_frame == 0)
					{
					//End in the helpless state if the attack didn't connect
					if (!attack_connected())
						{
						attack_stop(PLAYER_STATE.helpless);
						}
					else
						{
						attack_stop();
						}
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move();
	
	if (run)
		{
		hurtbox_anim_match(spr_nspec_homing_attack_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */