///@category Gameplay
///@param {array} player_input_buffer_array		An array of buffers that holds the inputs for each player
///@param {int}	[relative_frame]				(Only for online) The index of the current frame in the frames array
/*
Advances the game by one frame.
*/
function game_advance_frame() {
	with(obj_game)
		{
		player_inputs = argument[0];
		var _relative_frame = argument_count > 1 ? argument[1] : undefined;
		
		#region Update Player Inputs
		//The order doesn't need to be synced
		with(obj_player)
			{
			input_update(obj_game.player_inputs[@ player_number]);
			}
		#endregion
		
		/*----------------------------------------------------------------*/
		#region Normal / Startup
		if (state == GAME_STATE.normal || state == GAME_STATE.startup)
			{
			/*TIMERS*/
			current_frame++;
			if (state != GAME_STATE.startup) then game_time++;
			hud_1v1_scoreboard_frame = max(0, --hud_1v1_scoreboard_frame);
			
			/*PRNG*/
			for(var i = 0; i < prng_channels; i++)
				{
				prng_numbers[@ i] = ((prng_multiplier * prng_numbers[@ i]) + prng_increment) % prng_range;
				if (i > 0 && abs(prng_numbers[@ i - 1] - prng_numbers[@ i]) < 100)
					{
					prng_numbers[@ i] = ((prng_multiplier * prng_numbers[@ i]) + prng_increment) % prng_range;
					}
				}
				
			/*ITEMS*/
			item_spawn_script();
				
			/*VERLET*/
			verlet_system_update(verlet_system);
	
			/*UPDATE ALL MOVING PLATFORMS*/
			with_synced_object(obj_block_moving, function() 
				{
				event_user(Game_Event_Step);
				});
	
			/*UPDATE ALL PLAYERS*/
			with_synced_object(obj_player, function() 
				{
				event_user(Game_Event_Step);
				});
		
			/*UPDATE ALL ENTITIES*/
			with_synced_object(obj_entity, function() 
				{
				event_user(Game_Event_Step);
				});
		
			/*UPDATE ALL HURTBOXES*/
			with_synced_object(obj_hurtbox, function() 
				{
				event_user(Game_Event_Step);
				});
		
			/*CALCULATE HITBOX ORDER*/
			//Add all of the hitboxes to the priority queue to sort
			//Any hitboxes created from a hitbox user event will not have their user event run until the NEXT frame
			with(obj_hitbox)
				{
				ds_priority_add(other.hitbox_priority_queue, id, sync_id * (check_first ? -1 : 1));
				}
		
			//Update hitboxes based on the priority queue
			while(!ds_priority_empty(hitbox_priority_queue))
				{
				with(ds_priority_delete_min(hitbox_priority_queue))
					{
					event_user(Game_Event_Step);
					}
				}
				
			//Hitbox lifetime
			with_synced_object(obj_hitbox, function()
				{
				event_user(2);
				});
		
			/*UPDATE ALL EFFECTS*/
			with_synced_object(obj_vfx, function() 
				{
				event_user(Game_Event_Step);
				});
			
			if (!game_is_in_rollback())
				{
				part_system_update(Particle_System());
				}
	
			/*CAMERA*/
			camera_update();
	
			/*BACKGROUND FADE*/
			with(obj_stage_manager)
				{
				event_user(Game_Event_Step);
				}
		
			/*KNOCKOUTS*/
			with(obj_player)
				{
				if (!ignore_blastzones && !is_knocked_out())
					{
					if (blastzones_check())
						{
						//Normal KO
						if (!setting().match_screen_wrap)
							{
							knock_out();
							}
						//Screen wrapping
						else
							{
							var _blastzones = obj_stage_manager.blastzones;
							x = round(modulo(x, _blastzones.right - _blastzones.left) + _blastzones.left);
							y = round(modulo(y, _blastzones.bottom - _blastzones.top) + _blastzones.top);
							move_out_of_blocks(point_direction(0, 0, hsp, vsp) + 180);
							apply_damage(id, screen_wrap_damage);
							}
						}
					}
				}
	
			/*STOP FRAME ADVANCE*/
			if (go_to_next_frame && frame_advance_active)
				{
				go_to_next_frame = false;
				}
				
			/*ENDING THE GAME*/
			game_win_conditions();
			}
		#endregion
		/*----------------------------------------------------------------*/
		#region Entering the Pause meta state
		//Even if pause inputs are saved during replays, the game will not be paused
		if ((state == GAME_STATE.normal || state == GAME_STATE.startup || state == GAME_STATE.ending || state == GAME_STATE.cutscene) && 
			!setting().replay_mode && setting().pause_allow && !game_is_online())
			{
			var _pause_start = false;
			var _any_pause_hold = false;
			with(obj_player)
				{
				//Press / Held Input
				if (!is_cpu)
					{
					if (setting().pause_hold_input)
						{
						if (input_held(INPUT.pause))
							{
							other.pause_hold_frame++;
							_any_pause_hold = true;
							if (other.pause_hold_frame > pause_hold_time)
								{
								_pause_start = true;
								other.pause_hold_frame = 0;
								}
							}
						}
					else if (input_pressed(INPUT.pause, 0, true))
						{
						_pause_start = true;
						}
					}
				//Change the meta state
				if (_pause_start)
					{
					with(other)
						{
						meta_state = GAME_META_STATE.paused;
						frames_advanced = 0;
						pause_menu_current = 0;
						pause_menu_color = player_color_get(other.player_number);
						pause_menu_device_id = player_data_get(other.player_number, PLAYER_DATA.custom).device_id;
						}
					break;
					}
				}
			//Pause hold input counter
			if (!_any_pause_hold)
				{
				pause_hold_frame = 0;
				}
			}
		#endregion	
		/*----------------------------------------------------------------*/
		#region Startup countdown
		countdown = max(--countdown, 0);
		if (state == GAME_STATE.startup)
			{
			//Players can start as soon as "GO!" appears
			if (countdown <= countdown_start_time)
				{
				state = GAME_STATE.normal;
				with(obj_player)
					{
					state_set(PLAYER_STATE.idle);
					}
				}
			}
		#endregion
		/*----------------------------------------------------------------*/
		#region Ending countdown
		if (state == GAME_STATE.ending)
			{
			//Store camera position
			if (game_end_frame == game_end_time)
				{
				cam_x_ending = cam_x;
				cam_y_ending = cam_y;
				}
			
			//Counter
			game_end_frame = max(--game_end_frame, 0);
		
			//Play out all VFX at half speed
			if (game_end_frame % 2 == 0)
				{
				with(obj_vfx)
					{
					event_user(Game_Event_Step);
					}
				part_system_update(Particle_System());
				}
			
			//Apply Camera Shake and make sure the camera doesn't go out of the boundary
			//Can't use PRNG because the generator doesn't run while the game is ending!
			var _blastzones = obj_stage_manager.blastzones;
			var _cam_x = cam_x_ending;
			var _cam_y = cam_y_ending;
			_cam_x += choose(-cam_shake_h, cam_shake_h);
			_cam_y += choose(-cam_shake_v, cam_shake_v);

			if (_cam_x > _blastzones.right - cam_w - camera_boundary) then _cam_x -= cam_shake_h * 2;
			if (_cam_x < _blastzones.left + camera_boundary) then _cam_x += cam_shake_h * 2;
			if (_cam_y > _blastzones.bottom - cam_h - camera_boundary) then _cam_y -= cam_shake_v * 2;
			if (_cam_y < _blastzones.top + camera_boundary) then _cam_y += cam_shake_v * 2;

			//Gradually lower the camera shake amount
			cam_shake_h = approach(cam_shake_h, 0, 1);
			cam_shake_v = approach(cam_shake_v, 0, 1);

			//Set the camera position
			cam_x = clamp(_cam_x, _blastzones.left, _blastzones.right - cam_w);
			cam_y = clamp(_cam_y, _blastzones.top, _blastzones.bottom - cam_h);
			camera_set_view_pos(cam, cam_x, cam_y);
		
			//Timer under the end
			if (game_end_frame <= 0)
				{
				//Save the replay
				if (!setting().replay_mode && setting().replay_record)
					{
					replay_data_get().time = timestamp_create();
					}
			
				//Ending the game
				game_finish();
				
				return true;
				}
			}
		#endregion
		/*----------------------------------------------------------------*/
		#region Cutscenes
		if (state == GAME_STATE.cutscene)
			{
			/*TIMERS*/
			current_frame++;
			
			/*PRNG*/
			for(var i = 0; i < prng_channels; i++)
				{
				prng_numbers[@ i] = ((prng_multiplier * prng_numbers[@ i]) + prng_increment) % prng_range;
				if (i > 0 && abs(prng_numbers[@ i - 1] - prng_numbers[@ i]) < 100)
					{
					prng_numbers[@ i] = ((prng_multiplier * prng_numbers[@ i]) + prng_increment) % prng_range;
					}
				}

			/*UPDATE ALL PLAYERS*/
			with_synced_object(obj_player, function() 
				{
				event_user(Game_Event_Step);
				});
		
			/*UPDATE ALL ENTITIES*/
			with_synced_object(obj_entity, function() 
				{
				event_user(Game_Event_Step);
				});
		
			/*UPDATE ALL HURTBOXES*/
			with_synced_object(obj_hurtbox, function() 
				{
				event_user(Game_Event_Step);
				});
		
			/*CALCULATE HITBOX ORDER*/
			//Add all of the hitboxes to the priority queue to sort
			//Any hitboxes created from a hitbox user event will not have their user event run until the NEXT frame
			with(obj_hitbox)
				{
				ds_priority_add(other.hitbox_priority_queue, id, sync_id * (check_first ? -1 : 1));
				}
		
			//Update hitboxes based on the priority queue
			while(!ds_priority_empty(hitbox_priority_queue))
				{
				with(ds_priority_delete_min(hitbox_priority_queue))
					{
					event_user(Game_Event_Step);
					}
				}
				
			//Hitbox lifetime
			with_synced_object(obj_hitbox, function()
				{
				event_user(2);
				});
		
			/*UPDATE ALL EFFECTS*/
			with_synced_object(obj_vfx, function() 
				{
				event_user(Game_Event_Step);
				});
			
			if (!game_is_in_rollback())
				{
				part_system_update(Particle_System());
				}
	
			/*CAMERA*/
			camera_update();
	
			/*BACKGROUND FADE*/
			with(obj_stage_manager)
				{
				event_user(Game_Event_Step);
				}
	
			/*STOP FRAME ADVANCE*/
			if (go_to_next_frame && frame_advance_active)
				{
				go_to_next_frame = false;
				}
			}
		#endregion
		/*----------------------------------------------------------------*/
		#region Daynight Cycle Values
		if (setting().daynight_cycle_enable)
			{
			//Calculate the RGB values for Day / Night
			daynight_time = (current_frame / 40) % 100;
			var _time = daynight_time;

			//Normal
			if (_time < 30)
				{
				daynight_r = 0;
				daynight_g = 0;
				daynight_b = 0;
				}
			//Dusk
			else if (_time < 50)
				{
				var _amt = (_time - 30) / 20;
				daynight_r = lerp(0, 0.25, _amt);
				daynight_g = lerp(0, -0.1, _amt);
				daynight_b = lerp(0, 0.1, _amt);
				}
			//Night
			else if (_time < 80)
				{
				var _amt = (_time - 50) / 30;
				daynight_r = lerp(0.25, -0.4, _amt);
				daynight_g = lerp(-0.1,-0.3,_amt);
				daynight_b = lerp(0.1, -0.1, _amt);
				}
			//Dawn
			else if (_time < 100)
				{
				var _amt = (_time - 80) / 20;
				daynight_r = lerp(-0.4, 0, _amt);
				daynight_g = lerp(-0.3, 0, _amt);
				daynight_b = lerp(-0.1, 0, _amt);
				}
		
			//Tints
			assert(instance_exists(obj_stage_manager), "[game_advance_frame] No instance of obj_stage_manager exists for the daynight cycle");
			if (_time > 60 && _time < 75)
				{
				var _amt = (_time - 60) / 15;
				obj_stage_manager.stage_tint[@ 0] = lerp(0.0, 0.35, _amt);
				obj_stage_manager.stage_tint[@ 1] = lerp(0.0, 0.4, _amt);
				obj_stage_manager.stage_tint[@ 2] = lerp(0.0, 0.3, _amt);
				}
			else if (_time >= 75 && _time < 100)
				{
				var _amt = (_time - 75) / 25;
				obj_stage_manager.stage_tint[@ 0] = lerp(0.35, 0.0, _amt);
				obj_stage_manager.stage_tint[@ 1] = lerp(0.4, 0.0, _amt);
				obj_stage_manager.stage_tint[@ 2] = lerp(0.3, 0.0, _amt);
				}
			}
		#endregion
		}
		
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */