///@category Inputs
///@param {buffer} buffer		The input buffer to add the simulated inputs to
/*
Simulates inputs for the CPU player based on the CPU's type and circumstances.
*/
function cpu_script_base() {
	assert(is_cpu, "[cpu_script_base] Player ", player_number, " called the cpu_script_base function even though they aren't a CPU!");

	//CPU properties
	var _cpu_type = cpu_type;
	
	var _cpu_time = obj_game.current_frame;
	
	//Temporary variables
	var _b = argument[0];
	buffer_seek(_b, buffer_seek_start, 0);
	var _lx = 0;
	var _ly = 0;
	var _rx = 0;
	var _ry = 0;
	
	cpu_inputs_bitflag = 0;
	
	//CPU Stage Data
	var _cpu_up_b_distance = obj_stage_manager.cpu_up_b_distance;
	var _cpu_main_stage_distance = obj_stage_manager.cpu_main_stage_distance;
	
	#region CPU Types
	switch(_cpu_type)
		{
		case CPU_TYPE.idle:
			#region IDLE
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			else if (state == PLAYER_STATE.hitlag)
				{
				//No DI or ASDI
				_lx = 0;
				_ly = 0;
				//Attempt to tech immediately
				cpu_press(INPUT.shield);
				}
			else if (state == PLAYER_STATE.hitstun || state == PLAYER_STATE.balloon)
				{
				//No drift DI
				}
			else if (state == PLAYER_STATE.helpless)
				{
				//Drift toward the center of the room
				_lx = _center;
				_ly = -1;
				//Wall Jump
				if (collision(x + 1, y, [FLAG.solid]) || collision(x - 1, y, [FLAG.solid]))
					{
					cpu_press(INPUT.jump);
					}
				}
			else
				{
				if (!on_ground())
					{
					//When far from the center of the room, or not above the stage
					var _far = abs(x - (room_width / 2)) > _cpu_main_stage_distance;
					var _above_ground;
					if (_far)
						{
						_above_ground = false;
						}
					else
						{
						_above_ground = collision_line(x, y, x, room_height, obj_solid, false, true) != noone;
						}
					if (_far || !_above_ground)
						{
						_lx = _center;
						_ly = -1;
						//Occasionally double jump when recovering
						if (double_jumps > 0)
							{
							if (_cpu_time % 30 == 0)
								{
								cpu_press(INPUT.jump);
								}
							}
						//Use Up B when below the Up B threshold
						if (y > (room_height - _cpu_up_b_distance))
							{
							if (vsp >= 0)
								{
								cpu_press(INPUT.special);
								cpu_hold(INPUT.special);
								}
							}
						}
					else
						{
						//Angle Up B toward the stage
						if (state == PLAYER_STATE.attacking && attack_script == my_attacks[$ "Uspec"])
							{
							_lx = _center;
							_ly = -1;
							}
						}
					}
				else
					{
					//Idle
					_lx = 0;
					_ly = 0;
					}
				}
			break;
			#endregion
		case CPU_TYPE.attack:
			#region ATTACK
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			if (state == PLAYER_STATE.respawning)
				{
				//Drop down from the respawn platform
				_ly = 1;
				}
			else if (state == PLAYER_STATE.hitlag)
				{
				//Occasionally tech
				if (random(100) < 4) then cpu_press(INPUT.shield);
				//DI randomly
				_lx = random_range(-1, 1);
				_ly = random_range(-1, 1);
				}
			else if (state == PLAYER_STATE.hitstun || state == PLAYER_STATE.balloon)
				{
				//Drift toward the nearest ledge
				var _ledge = instance_nearest(x, y, obj_ledge);
				if (_ledge != noone)
					{
					_lx = sign(_ledge.x - x);
					}
				//Drift toward the center of the room
				else
					{
					_lx = _center;
					}
				_ly = -1;
				//Mashup airdodge or jump
				if (random(100) < 5) then cpu_press(INPUT.shield);
				else if (random(100) < 5) then cpu_press(INPUT.jump);
				}
			else if (state == PLAYER_STATE.helpless)
				{
				//When far from the center of the room, or not above the stage
				var _far = abs(x - (room_width / 2)) > _cpu_main_stage_distance;
				if (_far)
					{
					//Constantly jump when helpless (in an attempt to wall jump)
					_lx = _center;
					_ly = -1;
					cpu_press(INPUT.jump);
					}
				else
					{
					//Fastfall when above ground
					if (collision_line(x, y, x, room_height, obj_solid, false, true) != noone)
						{
						_lx = _center;
						_ly = choose(-1, 1);
						}
					}
				}
			else if (state == PLAYER_STATE.knockdown)
				{
				_lx = 0;
				_ly = 0;
				
				//Choose a random option
				if (state_time >= knockdown_time_min)
					{
					var _option = irandom(4);
					if (_option == 0)
						{
						_lx = -1;
						}
					else if (_option == 1)
						{
						_lx = 1;
						}
					else if (_option == 2)
						{
						_ly = -1;
						cpu_hold(INPUT.jump);
						}
					else if (_option == 3)
						{
						cpu_hold(INPUT.attack);
						}
					else
						{
						//Do nothing
						}
					}
				}
			else if (state == PLAYER_STATE.grabbing)
				{
				//Automatically throw before the opponent breaks free
				if (state_frame < 10)
					{
					//Throw away from the center of the stage at > 60%
					if (grabbed_id != noone && instance_exists(grabbed_id) && grabbed_id.damage > 60)
						{
						_lx = -_center;
						}
					else
						{
						//Throw up or down
						_ly = choose(-1, 1);
						}
					}
				//Pummel
				else if (state_frame > 30)
					{
					cpu_press(INPUT.attack);
					}
				}
			else if (state == PLAYER_STATE.ledge_hang)
				{
				//Choose a random ledge option
				if (irandom(100) < 15)
					{
					var _option = choose_weighted([0, 5, 1, 20, 2, 10, 3, 10, 4, 5, 5, 15]);
					//Jump
					if (_option == 1)
						{
						cpu_press(INPUT.jump);
						}
					//Attack
					else if (_option == 2)
						{
						cpu_press(INPUT.attack);
						}
					//Roll
					else if (_option == 3)
						{
						cpu_press(INPUT.shield);
						}
					//Normal Getup
					else if (_option == 4)
						{
						_lx = _center;
						}
					//Let Go
					else if (_option == 5)
						{
						_lx = -_center;
						}
					}
				}
			//For ANY other state
			else
				{
				//Aerial
				if (!on_ground())
					{
					//When far from the center of the room, or not above the stage
					var _far = abs(x - (room_width / 2)) > _cpu_main_stage_distance;
					var _above_ground;
					if (_far)
						{
						_above_ground = false;
						}
					else
						{
						_above_ground = (collision_line(x, y, x, room_height, obj_solid, false, true) != noone);
						}
					//Recovering
					if (_far || !_above_ground)
						{
						_lx = _center;
						_ly = -1;
						//Occasionally double jump when recovering
						if (double_jumps > 0)
							{
							if (_cpu_time % 40 == 0)
								{
								cpu_press(INPUT.jump);
								}
							}
						//Use Up B when below the Up B threshold
						if (y > (room_height - _cpu_up_b_distance))
							{
							if (vsp >= 0)
								{
								cpu_press(INPUT.special);
								cpu_hold(INPUT.special);
								}
							}
						}
					else
						{
						//Angle Up B toward the stage, if you are already using it
						if (state == PLAYER_STATE.attacking && attack_script == my_attacks[$ "Uspec"])
							{
							_lx = _center;
							_ly = -1;
							}
						else
							{
							//Jump/attack when close to opponents
							var _nearest = find_nearest_player(x, y, infinity, player_team, false);
							if (_nearest != noone)
								{
								var _dir = point_direction(x, y, _nearest.x, _nearest.y);
								//Move toward the nearest player horizontally
								_lx = _nearest.x > x ? 1 : -1;
								if (abs(x - _nearest.x) < 40)
									{
									//If the opponent is above, double jump
									if ((y - _nearest.y) < -60)
										{
										if (_cpu_time % 15 == 0)
											{
											cpu_press(INPUT.jump);
											}
										}
									//Attack towards the other player
									if (random(100) < 15)
										{
										_lx = lengthdir_x(1, _dir);
										_ly = lengthdir_y(1, _dir);
										cpu_press(INPUT.attack);
										}
									//Airdodging away from the other player immediately
									if (array_length(_nearest.my_hitboxes) > 0)
										{
										_lx = lengthdir_x(-1, _dir);
										_ly = lengthdir_y(-1, _dir);
										cpu_press(INPUT.shield);
										}
									}
								}

							//Random attacks in any direction
							if (random(100) < 5)
								{
								_lx = random_range(-1, 1);
								_ly = random_range(-1, 1);
								cpu_press(choose_weighted([INPUT.attack, 50, INPUT.special, 30, INPUT.smash, 15, INPUT.grab, 5]));
								}
							}
							
						//Hitfalling
						if (self_hitlag_frame > 0)
							{
							_ly = choose(-1, 1);
							}
						}
					}
				//Grounded
				else
					{
					_lx = 0;
					_ly = 0;
				
					//Find the nearest opponent
					var _shield = false;
					var _nearest = find_nearest_player(x, y, infinity, player_team, false);
					if (_nearest != noone)
						{
						var _dir = point_direction(x, y, _nearest.x, _nearest.y);
						
						//Move toward the nearest player
						_lx = _nearest.x > x ? 1 : -1;
							
						//Occasionally wavedash
						if (random(100) < 5)
							{
							cpu_press(INPUT.jump);
							cpu_press(INPUT.shield);
							_ly = 0;
							}
						
						//Shield if they are attacking
						switch(shield_type)
							{
							case SHIELD_TYPE.perfect_shield_start:
							case SHIELD_TYPE.parry_shield:
								_shield = array_length(_nearest.my_hitboxes) > 0 && shield_hp > 20;
								break;
							case SHIELD_TYPE.parry_press:
								_shield = array_length(_nearest.my_hitboxes) > 0;
								break;
							}
				
						//Do an action when close to an opponent
						if (abs(x - _nearest.x) < 50)
							{
							//If the opponent is above, jump
							if ((y - _nearest.y) > 60)
								{
								if (state != PLAYER_STATE.jumpsquat)
									{
									cpu_press(INPUT.jump);
									}
								cpu_hold(INPUT.jump);
								}
							//If the opponent is not too far below
							else if ((y - _nearest.y) > -60 && random(100) < 10)
								{
								cpu_press(choose_weighted([INPUT.jump, 15, INPUT.grab, 30, INPUT.attack, 5, INPUT.smash, 5]));
								}
							else
								{
								//Final Smashes
								if (final_smash_uses > 0 && random(100) < 50)
									{
									cpu_press(INPUT.special);
									cpu_release(INPUT.attack);
									cpu_release(INPUT.jump);
									cpu_release(INPUT.grab);
									cpu_release(INPUT.smash);
									_lx = 0;
									_ly = 0;
									}
								}
							}
							
						//Random attacks
						if (random(100) < 2)
							{
							_lx = lengthdir_x(1, _dir);
							_ly = lengthdir_y(1, _dir);
							cpu_press(choose_weighted([INPUT.attack, 50, INPUT.special, 20, INPUT.jump, 15]));
							}
						}
					//If there is no nearest opponent, walk to the center of the stage
					else
						{
						_lx = (_center * stick_flick_amount);
						_ly = -1;
						}
						
					//Drop through plats
					if (on_plat())
						{
						if (random(100) < 5)
							{
							_ly = 1;
							}
						}
						
					//Reacting to attacks
					if (_shield)
						{
						cpu_hold(INPUT.shield);
						}
					}
				}
			break;
			#endregion
		case CPU_TYPE.shield_hold:
			#region SHIELD_TYPE HOLD
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			var _shield = false;
			
			//Find the nearest opponent
			var _nearest = find_nearest_player(x, y, infinity, player_team, false);
			if (_nearest != noone)
				{
				_shield = (_nearest.state == PLAYER_STATE.attacking);
				}
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			//Attempt to tech
			else if (state == PLAYER_STATE.hitlag)
				{
				cpu_press(INPUT.shield);
				}
				
			if (on_ground())
				{
				//Shielding
				if (_shield)
					{
					cpu_hold(INPUT.shield);
					}
				}
			else
				{
				if (abs(x - room_width / 2) > 200)
					{
					//Drift toward the center of the room
					_lx = _center;
					if (vsp > -1)
						{
						//Double jump or Up B when falling
						if (double_jumps > 0)
							{
							cpu_press(INPUT.jump);
							}
						else if (y > room_height - _cpu_up_b_distance)
							{
							cpu_press(INPUT.special);
							_ly = -1;
							}
						}
					}
				}
			break;
			#endregion
		case CPU_TYPE.shield_grab:
			#region SHIELD_TYPE GRAB
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			var _shield_multihit_attacks = true;
			var _shield = false;
			var _grab = false;
			
			//Find the nearest opponent
			var _nearest = find_nearest_player(x, y, infinity, player_team, false);
			
			if (_nearest != noone)
				{
				_shield = (_nearest.attack_frame == 1 || array_length(_nearest.my_hitboxes) > 0);
				if (_shield_multihit_attacks)
					{
					_grab = (state == PLAYER_STATE.shielding && array_length(_nearest.my_hitboxes) == 0);
					}
				else
					{
					_grab = (state == PLAYER_STATE.shielding && _shield);
					}
				}
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			//Attempt to tech
			else if (state == PLAYER_STATE.hitlag)
				{
				cpu_press(INPUT.shield);
				}
			if (on_ground())
				{
				//Shielding
				if (_shield)
					{
					cpu_hold(INPUT.shield);
					}
				//Grab in the direction of the nearest player
				if (_nearest != noone)
					{
					if (_grab)
						{
						_lx = (_nearest.x > x ? 0.5 : -0.5);
						cpu_press(INPUT.grab);
						}
					if (state == PLAYER_STATE.idle && input_pressed(INPUT.grab, buffer_time_standard, false))
						{
						_lx = (_nearest.x > x ? 1 : -1);
						}
					}
				if (state == PLAYER_STATE.grabbing)
					{
					//Automatically throw opponent
					if (state_frame < 10)
						{
						_lx = choose(-1, 0, 1);
						_ly = choose(-1, 0, 1);
						}
					//Pummel
					else if (state_frame > 30)
						{
						cpu_press(INPUT.attack);
						}
					}
				}
			else
				{
				if (abs(x - room_width / 2) > 200)
					{
					//Drift toward the center of the room
					_lx = _center;
					//Airdodging
					if (_shield)
						{
						cpu_press(INPUT.shield);
						}
					if (vsp > -1)
						{
						//Double jump or Up B when falling
						if (double_jumps > 0)
							{
							cpu_press(INPUT.jump);
							}
						else if (y > room_height - _cpu_up_b_distance)
							{
							cpu_press(INPUT.special);
							_ly = -1;
							}
						}
					}
				}
			break;
			#endregion
		case CPU_TYPE.shield_attack:
			#region SHIELD_TYPE ATTACK
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			var _shield_multihit_attacks = true;
			var _shield = false;
			var _attack = false;
			
			//Find the nearest opponent
			var _nearest = find_nearest_player(x, y, infinity, player_team, false);
			if (_nearest != noone)
				{
				_shield = (_nearest.attack_frame == 1 || array_length(_nearest.my_hitboxes) > 0);
				if (_shield_multihit_attacks)
					{
					_attack = (state == PLAYER_STATE.shielding && array_length(_nearest.my_hitboxes) == 0);
					}
				else
					{
					_attack = (state == PLAYER_STATE.shielding && _shield);
					}
				}

			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			//Attempt to tech
			else if (state == PLAYER_STATE.hitlag)
				{
				cpu_press(INPUT.shield);
				}
			if (on_ground())
				{
				//Shielding
				if (_shield)
					{
					cpu_hold(INPUT.shield);
					}
				//Up B out of shield
				if (_attack)
					{
					if (scs[@ SCS.jumpsquat_attacks])
						{
						cpu_press(INPUT.jump);
						}
					cpu_press(INPUT.special);
					}
				if (_nearest != noone)
					{
					_ly = -1;
					if (_attack)
						{
						_lx = (_nearest.x > x ? 0.5 : -0.5);
						}
					if (state == PLAYER_STATE.attacking)
						{
						_lx = (_nearest.x > x ? 1 : -1);
						}
					}
				if (state == PLAYER_STATE.grabbing)
					{
					//Throw
					if (state_frame < 10)
						{
						_lx = choose(-1, 0, 1);
						_ly = choose(-1, 0, 1);
						}
					//Pummel
					else if (state_frame > 30)
						{
						cpu_press(INPUT.attack);
						}
					}
				}
			else
				{
				if (abs(x - room_width / 2) > 200)
					{
					_lx = _center;
					if (_shield)
						{
						cpu_press(INPUT.shield);
						}
					if (vsp > -1)
						{
						if (double_jumps > 0)
							{
							cpu_press(INPUT.jump);
							}
						else if (y > room_height - _cpu_up_b_distance)
							{
							//Up B
							cpu_press(INPUT.special);
							_ly = -1;
							}
						}
					}
				}
			break;
			#endregion
		case CPU_TYPE.di_in:
			#region DI In
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			else if (state == PLAYER_STATE.hitlag)
				{
				//Calculate the best DI
				var _len1 = abs(lengthdir_x(1, knockback_dir + di_default));
				var _len2 = abs(lengthdir_x(1, knockback_dir - di_default));
				var _hold_angle = (_len1 > _len2 ? knockback_dir - 90 : knockback_dir + 90);
				//Hold inwards and try to tech
				_lx = lengthdir_x(1, _hold_angle);
				_ly = lengthdir_y(1, _hold_angle);
				cpu_press(INPUT.shield);
				}
			else if (state == PLAYER_STATE.hitstun || state == PLAYER_STATE.balloon)
				{
				//Drift inwards
				_lx = _center;
				_ly = 0;
				}
			else if (state == PLAYER_STATE.helpless)
				{
				_lx = _center;
				_ly = -1;
				//Wall Jump
				if (collision(x + 1, y, [FLAG.solid]) || collision(x - 1, y, [FLAG.solid]))
					{
					cpu_press(INPUT.jump);
					}
				}
			else
				{
				if (!on_ground())
					{
					//When far from the center of the room, or not above the stage
					var _far = abs(x - (room_width / 2)) > _cpu_main_stage_distance;
					var _above_ground;
					if (_far)
						{
						_above_ground = false;
						}
					else
						{
						_above_ground = collision_line(x, y, x, room_height, obj_solid, false, true) != noone;
						}
					if (_far || !_above_ground)
						{
						_lx = _center;
						_ly = -1;
						//Occasionally double jump when recovering
						if (double_jumps > 0)
							{
							if (_cpu_time % 30 == 0)
								{
								cpu_press(INPUT.jump);
								}
							}
						//Use Up B when below the Up B threshold
						if (y > (room_height - _cpu_up_b_distance))
							{
							if (vsp >= 0)
								{
								cpu_press(INPUT.special);
								cpu_hold(INPUT.special);
								}
							}
						}
					else
						{
						//Angle Up B toward the stage
						if (state == PLAYER_STATE.attacking && attack_script == my_attacks[$ "Uspec"])
							{
							_lx = _center;
							_ly = -1;
							}
						}
					}
				else
					{
					_lx = 0;
					_ly = 0;
					}
				}
			break;
			#endregion
		case CPU_TYPE.di_out:
			#region DI Out
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			else if (state == PLAYER_STATE.hitlag)
				{
				//Calculate the best DI
				var _len1 = abs(lengthdir_x(1, knockback_dir + di_default));
				var _len2 = abs(lengthdir_x(1, knockback_dir - di_default));
				var _hold_angle = (_len1 < _len2 ? knockback_dir - 90 : knockback_dir + 90);
				//Hold outwards and try to tech
				_lx = lengthdir_x(1, _hold_angle);
				_ly = lengthdir_y(1, _hold_angle);
				cpu_press(INPUT.shield);
				}
			else if (state == PLAYER_STATE.hitstun || state == PLAYER_STATE.balloon)
				{
				//Drift outwards
				_lx = -_center;
				_ly = 0;
				}
			else if (state == PLAYER_STATE.helpless)
				{
				_lx = _center;
				_ly = -1;
				//Wall Jump
				if (collision(x + 1, y, [FLAG.solid]) || collision(x - 1, y, [FLAG.solid]))
					{
					cpu_press(INPUT.jump);
					}
				}
			else
				{
				if (!on_ground())
					{
					//When far from the center of the room, or not above the stage
					var _far = abs(x - (room_width / 2)) > _cpu_main_stage_distance;
					var _above_ground;
					if (_far)
						{
						_above_ground = false;
						}
					else
						{
						_above_ground = collision_line(x, y, x, room_height, obj_solid, false, true) != noone;
						}
					if (_far || !_above_ground)
						{
						_lx = _center;
						_ly = -1;
						//Occasionally double jump when recovering
						if (double_jumps > 0)
							{
							if (_cpu_time % 30 == 0)
								{
								cpu_press(INPUT.jump);
								}
							}
						//Use Up B when below the Up B threshold
						if (y > (room_height - _cpu_up_b_distance))
							{
							if (vsp >= 0)
								{
								cpu_press(INPUT.special);
								cpu_hold(INPUT.special);
								}
							}
						}
					else
						{
						//Angle Up B toward the stage
						if (state == PLAYER_STATE.attacking && attack_script == my_attacks[$ "Uspec"])
							{
							_lx = _center;
							_ly = -1;
							}
						}
					}
				else
					{
					_lx = 0;
					_ly = 0;
					}
				}
			break;
			#endregion
		case CPU_TYPE.di_random:
			#region DI Random
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			else if (state == PLAYER_STATE.hitlag)
				{
				//DI and ASDI randomly
				_lx = random_range(-1, 1);
				_ly = random_range(-1, 1);
				cpu_press(INPUT.shield);
				}
			else if (state == PLAYER_STATE.hitstun || state == PLAYER_STATE.balloon)
				{
				_ly = -1;
				}
			else if (state == PLAYER_STATE.helpless)
				{
				_lx = _center;
				_ly = -1;
				if (collision(x + 1, y, [FLAG.solid]) || collision(x - 1, y, [FLAG.solid]))
					{
					cpu_press(INPUT.jump);
					}
				}
			else
				{
				if (!on_ground())
					{
					//When far from the center of the room, or not above the stage
					var _far = abs(x - (room_width / 2)) > _cpu_main_stage_distance;
					var _above_ground;
					if (_far)
						{
						_above_ground = false;
						}
					else
						{
						_above_ground = collision_line(x, y, x, room_height, obj_solid, false, true) != noone;
						}
					if (_far || !_above_ground)
						{
						_lx = _center;
						_ly = -1;
						//Occasionally double jump when recovering
						if (double_jumps > 0)
							{
							if (_cpu_time % 30 == 0)
								{
								cpu_press(INPUT.jump);
								}
							}
						//Use Up B when below the Up B threshold
						if (y > (room_height - _cpu_up_b_distance))
							{
							if (vsp >= 0)
								{
								cpu_press(INPUT.special);
								cpu_hold(INPUT.special);
								}
							}
						}
					else
						{
						//Angle Up B toward the stage
						if (state == PLAYER_STATE.attacking && attack_script == my_attacks[$ "Uspec"])
							{
							_lx = _center;
							_ly = -1;
							}
						}
					}
				else
					{
					_lx = 0;
					_ly = 0;
					}
				}
			break;
			#endregion
		case CPU_TYPE.parry_ult:
			#region PARRY ULTIMATE
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			var _parry_multihit_attacks = false;
			var _shield = false;
			var _attacked = false;
			
			//Find the nearest player
			var _nearest = find_nearest_player(x, y, infinity, player_team, false);
			if (_nearest != noone)
				{
				_shield = (_nearest.state == PLAYER_STATE.attacking);
				_attacked = (_nearest.attack_frame == 1 || array_length(_nearest.my_hitboxes) > 0) && _nearest.self_hitlag_frame == 0;
				}
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			
			if (on_ground())
				{
				//Shield
				if (_shield && !_attacked)
					{
					cpu_hold(INPUT.shield);
					}
				if (state == PLAYER_STATE.shield_release)
					{
					if (_shield && _parry_multihit_attacks)
						{
						cpu_hold(INPUT.shield);
						}
					else
						{
						//Grab after parrying
						cpu_press(INPUT.grab);
						}
					}
				
				if (state == PLAYER_STATE.idle && input_pressed(INPUT.grab, buffer_time_standard, false) && _nearest != noone)
					{
					_lx = (_nearest.x > x ? 1 : -1);
					}
				if (state == PLAYER_STATE.grabbing)
					{
					if (state_frame < 10)
						{
						_lx = choose(-1, 0, 1);
						_ly = choose(-1, 0, 1);
						}
					else if (state_frame > 30)
						{
						cpu_press(INPUT.attack);
						}
					}
				}
			else
				{
				if (abs(x - room_width / 2) > 200)
					{
					_lx = _center;
					if (_shield)
						{
						cpu_press(INPUT.shield);
						}
					if (vsp > -1)
						{
						if (double_jumps > 0)
							{
							cpu_press(INPUT.jump);
							}
						else if (y > room_height - _cpu_up_b_distance)
							{
							//Up B
							cpu_press(INPUT.special);
							_ly = -1;
							}
						}
					}
				}
			break;
			#endregion
		case CPU_TYPE.airdodge:
			#region AIRDODGE_TYPE
			var _center = sign((room_width / 2) - x); //The direction toward the center of the stage
			
			if (state == PLAYER_STATE.respawning)
				{
				_ly = 1;
				}
			else if (state == PLAYER_STATE.hitlag)
				{
				//DI and ASDI randomly
				_lx = random_range(-1, 1);
				_ly = random_range(-1, 1);
				cpu_press(INPUT.shield);
				}
			else if (state == PLAYER_STATE.hitstun || state == PLAYER_STATE.balloon)
				{
				//Mash the shield button
				cpu_press(INPUT.shield);
				}
			else if (state == PLAYER_STATE.helpless)
				{
				_lx = _center;
				_ly = 0;
				}
			else if (!on_ground())
				{
				//When far from the center of the room, or not above the stage
				var _far = abs(x - (room_width / 2)) > _cpu_main_stage_distance;
				var _above_ground;
				if (_far)
					{
					_above_ground = false;
					}
				else
					{
					_above_ground = collision_line(x, y, x, room_height, obj_solid, false, true) != noone;
					}
				if (_far || !_above_ground)
					{
					_lx = _center;
					_ly = -1;
					//Occasionally double jump when recovering
					if (double_jumps > 0)
						{
						if (_cpu_time % 30 == 0)
							{
							cpu_press(INPUT.jump);
							}
						}
					//Use Up B when below the Up B threshold
					if (y > (room_height - _cpu_up_b_distance))
						{
						if (vsp >= 0)
							{
							cpu_press(INPUT.special);
							cpu_hold(INPUT.special);
							}
						}
					}
				else
					{
					//Angle Up B toward the stage
					if (state == PLAYER_STATE.attacking && attack_script == my_attacks[$ "Uspec"])
						{
						_lx = _center;
						_ly = -1;
						}
					}
				}
			else
				{
				_lx = 0;
				_ly = 0;
				}
			break;
			#endregion
		case CPU_TYPE.input_test: //DEBUG
			#region
			var _inputs = array_create(INPUT.LENGTH);
			for(var i = 0; i < INPUT.LENGTH; i++)
				{
				_inputs[@ (i * 2)] = i;
				_inputs[@ (i * 2) + 1] = 1;
				}
			
			if (prng_number(0, 100) > 10)
				{
				cpu_press(prng_choose_weighted(1, _inputs));
				}
			if (prng_number(2, 100) > 10)
				{
				cpu_hold(prng_choose_weighted(3, _inputs));
				}
			if (prng_number(4, 100) > 50)
				{
				_lx = random_range(-1, 1);
				_ly = random_range(-1, 1);
				}
			break;
			#endregion
		default: crash("[cpu_script_base] CPU type is invalid (", _cpu_type, ")"); break;
		}
	#endregion
	
	//Character-specific CPU scripts
	var _script = character_data_get(character, CHARACTER_DATA.cpu_script);
	if (!is_undefined(_script))
		{
		var _returned = _script(_lx, _ly, _rx, _ry);
		_lx = _returned.lx;
		_ly = _returned.ly;
		_rx = _returned.rx;
		_ry = _returned.ry;
		}
	
	//Write to the buffer
	buffer_write(_b, buffer_u32, cpu_inputs_bitflag);
	
	buffer_write(_b, buffer_s8, round(_lx * 100.0));
	buffer_write(_b, buffer_s8, round(_ly * 100.0));
	buffer_write(_b, buffer_s8, round(_rx * 100.0));
	buffer_write(_b, buffer_s8, round(_ry * 100.0));
	
	return;
}
/* Copyright 2023 Springroll Games / Yosi */