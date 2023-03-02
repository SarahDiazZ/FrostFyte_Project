///@category Gameplay
/*
This function updates the camera to move closer to the average position of all players.
If camera zooming is enabled, this function also changes the camera width and height based on the position of players.
It can only be run by <obj_game>, and requires <obj_stage_manager> to be in the room.
*/
function camera_update() {
	//Get the blastzones from obj_stage_manager
	var _blastzones = obj_stage_manager.blastzones;
	var _blastzone_center_x = mean(_blastzones.left, _blastzones.right);
	var _blastzone_center_y = mean(_blastzones.top, _blastzones.bottom);
		
	//Automatic update
	if (cam_auto)
		{
		//Average of Player positions
		//Reset the goal position
		cam_x_goal = 0;
		cam_y_goal = 0;
		var _num_of_active_players = 0;
		var _set = true;
		var _player_max_x = 0, _player_min_x = 0, _player_max_y = 0, _player_min_y = 0;

		//Get player positions
		with(obj_player)
			{
			if (!is_knocked_out())
				{
				other.cam_x_goal += x;
				other.cam_y_goal += y;
		
				//Increase the number of active players so that the camera doesn't focus on KO'ed players
				_num_of_active_players += 1;
		
				//Get min and max
				if (_set)
					{
					_player_max_x = x;
					_player_min_x = x;
					_player_max_y = y;
					_player_min_y = y;
					_set = false;
					}
				else
					{
					_player_max_x = max(_player_max_x, x);
					_player_min_x = min(_player_min_x, x);
					_player_max_y = max(_player_max_y, y);
					_player_min_y = min(_player_min_y, y);
					}
				}
			}
	
		//Divide by the number of active players to get average
		if (_num_of_active_players != 0)
			{
			cam_x_goal /= _num_of_active_players;
			cam_y_goal /= _num_of_active_players;
			}
		else
			{
			//Center camera if all players are KO'ed
			cam_x_goal = _blastzone_center_x;
			cam_y_goal = _blastzone_center_y;
			}
	
		//Camera offset
		cam_y_goal += setting().camera_y_offset;

		//Camera special zoom
		var _zoomed_camera = false;
		if (camera_special_zoom_enable)
			{
			if (background_get_clear_amount() == 0)
				{
				cam_w_goal = camera_special_zoom_width;
				cam_h_goal = camera_special_zoom_height;
				if (!game_is_in_rollback())
					{
					cam_w = lerp(cam_w, cam_w_goal, camera_special_zoom_speed_in);
					cam_h = lerp(cam_h, cam_h_goal, camera_special_zoom_speed_in);
					}
				cam_shake_h = 0;
				cam_shake_v = 0;
				cam_x = cam_x_goal - (cam_w div 2);
				cam_y = cam_y_goal - (cam_h div 2);
				_zoomed_camera = true;
				}
			else if (!setting().camera_zoom_enable)
				{
				cam_w_goal = camera_width_start;
				cam_h_goal = camera_height_start;
				if (!game_is_in_rollback())
					{
					cam_w = lerp(cam_w, cam_w_goal, camera_special_zoom_speed_out);
					cam_h = lerp(cam_h, cam_h_goal, camera_special_zoom_speed_out);
					}
				_zoomed_camera = true;
				}
			}
		//Normal camera
		if (!_zoomed_camera)
			{
			if (setting().camera_zoom_enable)
				{
				_player_max_x += _player_min_x * camera_zoom_pad_xscale;
				_player_min_x += _player_min_x *-camera_zoom_pad_xscale;
				_player_max_y += _player_min_y * camera_zoom_pad_yscale;
				_player_min_y += _player_min_y *-camera_zoom_pad_yscale;
				//Calculate longest width
				var _lwidth = _player_max_x - _player_min_x;
	
				//Calculate longest height and corresponding width
				var _lheight = _player_max_y - _player_min_y;
				var _cwidth = _lheight * camera_ratio;
	
				//Get the largest one and use it as the height / width
				var _final_width = max(_lwidth, _cwidth);
				var _final_height = _final_width / camera_ratio;
	
				//Set the camera width and height
				cam_w_goal = clamp(_final_width * camera_zoom_pad_scale, camera_width_min, camera_width_max);
				cam_h_goal = clamp(_final_height * camera_zoom_pad_scale, camera_height_min, camera_height_max);
	
				//Zoom
				if (!game_is_in_rollback())
					{
					if (cam_w_goal > cam_w)
						{
						cam_w = lerp(cam_w, cam_w_goal, setting().camera_zoom_speed_out);
						cam_h = lerp(cam_h, cam_h_goal, setting().camera_zoom_speed_out);
						}
					else
						{
						cam_w = lerp(cam_w, cam_w_goal, setting().camera_zoom_speed_in);
						cam_h = lerp(cam_h, cam_h_goal, setting().camera_zoom_speed_in);
						}
					}
				_zoomed_camera = true;
				}
			}
		if (!_zoomed_camera)
			{
			//Keep the same width and height
			cam_w_goal = camera_width_start;
			cam_h_goal = camera_height_start;
			if (!game_is_in_rollback())
				{
				cam_w = lerp(cam_w, cam_w_goal, setting().camera_zoom_speed_out);
				cam_h = lerp(cam_h, cam_h_goal, setting().camera_zoom_speed_out);
				}
			_zoomed_camera = true;
			}

		//Subtract half of the dimensions to center
		cam_x_goal -= (cam_w div 2);
		cam_y_goal -= (cam_h div 2);
		}
	
	//Clamp so the camera doesn't go out of the boundary
	cam_x_goal = clamp(cam_x_goal, _blastzones.left + camera_boundary, _blastzones.right - cam_w - camera_boundary);
	cam_y_goal = clamp(cam_y_goal, _blastzones.top + camera_boundary, _blastzones.bottom - cam_h - camera_boundary);
	
	//Change the camera's position
	if (!game_is_in_rollback())
		{
		//Slowly move camera to position inside the room
		cam_x = clamp(lerp(cam_x, cam_x_goal, setting().camera_move_speed), _blastzones.left, _blastzones.right - cam_w);
		cam_y = clamp(lerp(cam_y, cam_y_goal, setting().camera_move_speed), _blastzones.top, _blastzones.bottom - cam_h);
		if (camera_rounding_enable)
			{
			cam_x = round(cam_x);
			cam_y = round(cam_y);
			}

		//Apply Camera Shake and make sure the camera doesn't go out of the boundary
		cam_x += prng_choose(0, -cam_shake_h, cam_shake_h);
		cam_y += prng_choose(1, -cam_shake_v, cam_shake_v);

		if (cam_x > _blastzones.right - cam_w - camera_boundary) then cam_x -= cam_shake_h * 2;
		if (cam_x < _blastzones.left + camera_boundary) then cam_x += cam_shake_h * 2;
		if (cam_y > _blastzones.bottom - cam_h - camera_boundary) then cam_y -= cam_shake_v * 2;
		if (cam_y < _blastzones.top + camera_boundary) then cam_y += cam_shake_v * 2;
		
		cam_x = clamp(cam_x, _blastzones.left, _blastzones.right - cam_w);
		cam_y = clamp(cam_y, _blastzones.top, _blastzones.bottom - cam_h);

		//Set the camera position
		camera_set_view_pos(cam, cam_x, cam_y);
		
		//Set the camera size
		if (camera_rounding_enable)
			{
			camera_set_view_size(cam, round(cam_w), round(cam_h));
			}
		else
			{
			camera_set_view_size(cam, cam_w, cam_h);
			}
		}
		
	//Gradually lower the camera shake amount
	cam_shake_h = approach(cam_shake_h, 0, 1);
	cam_shake_v = approach(cam_shake_v, 0, 1);
}
/* Copyright 2023 Springroll Games / Yosi */