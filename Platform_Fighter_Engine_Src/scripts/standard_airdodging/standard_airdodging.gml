///@category Player Standard States
/*
This script contains the default Airdodging state characters are given.

The Airdodging state is for players using an airdodge, and varies based on the chosen <airdodge_type>.
*/
function standard_airdodging() {
	//Contains the standard actions for the airdodge state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Airdodge"]);
			
			//Timers
			state_frame = airdodge_startup;
			state_phase = 0;
			switch(airdodge_type)
				{
				case AIRDODGE_TYPE.momentum_stop:
					{
					var _on_ground = on_ground();
					
					//Choose a control stick to use
					var _stick = stick_choose_by_input(INPUT.shield);
					if (stick_tilted(_stick))
						{
						var _dir = stick_get_direction(_stick);
						if (airdodge_direction_limit != -1)
							{
							var _d = (360 / airdodge_direction_limit);
							_dir = ((_dir + (_d / 2)) div _d) * _d;
							}
						airdodge_is_directional = true;
						airdodge_direction = _dir;
						if (wavedash_horizontal_assist && _on_ground)
							{
							if (abs(angle_difference(airdodge_direction, 0)) < wavedash_horizontal_threshold)
								{
								airdodge_direction = 0;
								}
							else if (abs(angle_difference(airdodge_direction, 180)) < wavedash_horizontal_threshold)
								{
								airdodge_direction = 180;
								} 
							}
						}
					else
						{
						airdodge_is_directional = false;
						airdodge_direction = 90;
						}
						
					//Speed
					//Please Note: The speed must be set here for wavelands to work
					if (airdodge_is_directional)
						{
						speed_set(lengthdir_x(airdodge_speed, airdodge_direction), lengthdir_y(airdodge_speed, airdodge_direction), false, false);
						//Prevent upward airdodges from jumpsquat
						if (airdodge_from_jumpsquat && !airdodge_upward_from_jumpsquat && _on_ground)
							{
							speed_set(0, 0, true, false);
							}
						}
					else
						{
						speed_set(0, 0, false, false);
						}
					
					//Waveland cancel
					if (check_waveland())
						{
						//Reset invulnerability
						invulnerability_set(INV.normal, 0);
						}
					else
						{
						speed_set(0, 0, false, false);
						
						//Visual effects
						if (airdodge_is_directional)
							{
							var _vfx = vfx_create(spr_dust_airdodge, 1, 0, 14, x, y, 2, _dir - 180, "VFX_Layer_Below");
							_vfx.vfx_yscale = prng_choose(0, 2, -2);
							}
							
						if (item_system_type == ITEM_SYSTEM_TYPE.standard)
							{
							//Pick up any nearby item at the start
							pick_up_item();
							}
						}
					break;
					}
				case AIRDODGE_TYPE.momentum_keep:
					{
					airdodge_is_directional = false;
					
					if (item_system_type == ITEM_SYSTEM_TYPE.standard)
						{
						//Pick up any nearby item at the start
						pick_up_item();
						}
					break;
					}
				case AIRDODGE_TYPE.accelerate:
					{
					//Choose a control stick to use
					var _stick = stick_choose_by_input(INPUT.shield);
					if (stick_tilted(_stick))
						{
						var _dir = stick_get_direction(_stick);
						airdodge_is_directional = true;
						if (airdodge_direction_limit != -1)
							{
							var _d = (360 / airdodge_direction_limit);
							_dir = ((_dir + (_d / 2)) div _d) * _d;
							}
						airdodge_direction = _dir;
						}
					else
						{
						airdodge_is_directional = false;
						}
						
					if (item_system_type == ITEM_SYSTEM_TYPE.standard)
						{
						//Pick up any nearby item at the start
						pick_up_item();
						}
					break;
					}
				}
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			switch(airdodge_type)
				{
				case AIRDODGE_TYPE.momentum_stop:
					{
					switch(state_phase)
						{
						case 0:
							{
							if (state_frame == 0)
								{
								state_phase++;
								state_frame = airdodge_active;
								
								//Sound
								game_sound_play(snd_airdodge);
						
								//Invulnerability
								invulnerability_set(INV.invincible, airdodge_active);
						
								//Speed
								if (airdodge_is_directional)
									{
									speed_set(lengthdir_x(airdodge_speed, airdodge_direction), lengthdir_y(airdodge_speed, airdodge_direction), false, false);
									}
								else
									{
									speed_set(0, 0, false, false);
									}
						
								//Waveland cancel
								if (check_waveland())
									{
									//Reset invulnerability
									invulnerability_set(INV.normal, 0);
									}
								}
							break;
							}
						case 1:
							{
							if (state_frame == 0)
								{
								state_phase++;
								state_frame = airdodge_endlag;
								}
						
							//Snap up onto solid blocks
							var _block = collision(x + hsp, y, [FLAG.solid]);
							if (_block != noone)
								{
								var _diff = (bbox_bottom - 1) - _block.bbox_top;
								if (_diff <= solid_snap_threshold)
									{
									if (!collision(x, y - (_diff + 1), [FLAG.solid]))
										{
										y -= _diff + 1;
										}
									}
								}
					
							//Move, without going through platforms
							move_hit_platforms();
					
							//Waveland cancel
							if (check_waveland())
								{
								//Reset invulnerability
								invulnerability_set(INV.normal, 0);
								}
							break;
							}
						case 2:
							{
							//No movement in endlag
							speed_set(0, 0, false, false);
					
							//Grabbing the ledge
							if (airdodge_allow_ledge_grab && check_ledge_grab()) then return;
					
							if (state_frame == 0)
								{
								state_phase = 0;
								state_set(PLAYER_STATE.aerial);
								return;
								}
							break;
							}
						}
					break;
					}
				case AIRDODGE_TYPE.momentum_keep:
					{
					switch(state_phase)
						{
						case 0:
							{
							if (state_frame == 0)
								{
								state_phase++;
								state_frame = airdodge_active;
								
								//Sound
								game_sound_play(snd_airdodge);
								
								//Invulnerability
								invulnerability_set(INV.invincible, airdodge_active);
								}
							break;
							}
						case 1:
							{
							if (state_frame == 0)
								{
								state_phase++;
								state_frame = airdodge_endlag;
								}
							break;
							}
						case 2:
							{
							//Grabbing the ledge
							if (airdodge_allow_ledge_grab && check_ledge_grab()) then return;
					
							if (state_frame == 0)
								{
								state_phase = 0;
								state_set(PLAYER_STATE.aerial);
								}
							break;
							}
						}
				
					//Aerial movement
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
			
					//Move, without going through platforms
					move_hit_platforms();
			
					//Landing
					if (on_ground())
						{
						state_set(PLAYER_STATE.in_lag);
						state_frame = airdodge_land_time;
						//Reset invulnerability
						invulnerability_set(INV.normal, 0);
						}
					break;
					}
				case AIRDODGE_TYPE.accelerate:
					{
					//Ultimate
					switch(state_phase)
						{
						case 0:
							{
							//Sound
							game_sound_play(snd_airdodge);
							
							if (!airdodge_is_directional)
								{
								friction_gravity(air_friction, grav, max_fall_speed);
								aerial_drift();
								}
							else
								{
								var spd = airdodge_dir_windup_speed, dir = (airdodge_direction - 180);
								speed_set(lengthdir_x(spd, dir), lengthdir_y(spd, dir), false, false);
								}
						
							//Boost in a direction
							if (state_frame == 0)
								{
								state_phase++;
								if (airdodge_is_directional)
									{
									state_frame = airdodge_dir_active;
									var spd = airdodge_dir_speed_min;
									if (airdodge_adjust_speed)
										{
										spd = lerp
											(
											airdodge_dir_speed_max,
											airdodge_dir_speed_min,
											(-dsin(airdodge_direction) * 0.5) + 0.5,
											);
										}
									var dir = airdodge_direction;
									speed_set(lengthdir_x(spd, dir), lengthdir_y(spd, dir), false, false);
									}
								else
									{
									state_frame = airdodge_active;
									}
								invulnerability_set(INV.invincible, state_frame);
								}
						
							//Move, without going through platforms
							move_hit_platforms();
							break;
							}
						case 1:
							{
							if (state_frame == 0)
								{
								state_phase++;
								if (airdodge_is_directional)
									{
									if (airdodge_adjust_endlag)
										{
										state_frame = lerp
											(
											airdodge_dir_endlag_min,
											airdodge_dir_endlag_max,
											(dsin(airdodge_direction) * 0.5) + 0.5,
											);
										}
									else
										{
										state_frame = airdodge_dir_endlag_min;
										}
									}
								else
									{
									state_frame = airdodge_endlag;
									}
								}
						
							//Speeds
							if (!airdodge_is_directional)
								{
								aerial_drift();
								friction_gravity(air_friction, grav, max_fall_speed);
								}
							else
								{
								friction_gravity(air_friction, airdodge_dir_grav, max_fall_speed);
								}
						
							//Move, without going through platforms
							move_hit_platforms();
							break;
							}
						case 2:
							{
							//Grabbing the ledge
							if (airdodge_allow_ledge_grab && check_ledge_grab()) then return;
					
							if (state_frame == 0)
								{
								state_phase = 0;
								state_set(PLAYER_STATE.aerial);
								}
						
							//Speeds
							friction_gravity(air_friction, grav, max_fall_speed);
							aerial_drift_momentum();
					
							//Move, without going through platforms
							move_hit_platforms();
							break;
							}
						}
				
					//Landing
					if (on_ground())
						{
						state_set(PLAYER_STATE.in_lag);
						state_frame = airdodge_land_time;
						//Reset invulnerability
						invulnerability_set(INV.normal, 0);
						}
					break;
					}
				}
			//No movement
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */