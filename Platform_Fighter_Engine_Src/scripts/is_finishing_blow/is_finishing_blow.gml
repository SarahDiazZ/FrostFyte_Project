///@category Attacking
///@param {real} full_knockback		The knockback the player will take
///@param {real} angle				The angle of the knockback
///@param {int} hitstun_frames		How many frames the hitstun will last
///@param {int} target_id			The id of the player being hit
///@param {bool} [balloon]			If the trajectory should be calculated as balloon knockback or not
/*
Attempts to calculate if an attack is guaranteed to knock out a player or not.
This is by no means an accurate calculation, and should never be used to decide the winner of a match.
The specifics of the calculation are as follows:
	- It plots out the trajectory of a player with 3 different DI angles (max DI counterclockwise, max DI clockwise, no DI)
	- If all three trajectories end up with the player outside the blastzones and do not collide with blocks, the function returns true
If launch trajectories are turned on, visible objects will be created along the trajectories.

Warning: There are some potential interruptions that are not accounted for, such as moving blocks.
*/
function is_finishing_blow() {
	var _kb = argument[0];
	var	_angle = argument[1];
	var _stun = argument[2];
	var _t = argument[3];
	var _balloon = argument_count > 4 ? argument[4] : false;

	var _tx = _t.x;
	var _ty = _t.y;
	var _hsp = 0;
	var _vsp = 0;
	var _stickx = 0;
	var _in_angle;
	var _ko_count = 0;

	//Clear existing launch trajectory points
	if (setting().show_launch_trajectories)
		{
		with(obj_launch_trajectory_point)
			{
			instance_destroy();
			}
		}
		
	//Choose which angle is "in" and which is "out"
	var _facing = sign(lengthdir_x(1, _angle));
	var _len1 = abs(lengthdir_x(1, _angle + di_angle));
	var _len2 = abs(lengthdir_x(1, _angle - di_angle));
	
	if (_len1 > _len2)
		{
		_in_angle = 2;
		}
	else
		{
		_in_angle = 1;
		}

	with(_t)
		{
		for(var i = 0; i < 3; i++)
			{
			//Change the angles to be checked
			if (i == 1)
				{
				_angle += di_angle;
				if (_in_angle == 1)
					_stickx = -_facing;
				else
					_stickx = _facing;
				}
			if (i == 2)
				{
				_angle -= di_angle * 2;
				if (_in_angle == 2)
					_stickx = -_facing;
				else
					_stickx = _facing;
				}
				
			_hsp = lengthdir_x(_kb, _angle);
			_vsp = lengthdir_y(_kb, _angle);
			
			//Reset position
			x = _tx;
			y = _ty;
	
			//Checks until the hitstun would be over (since you can airdodge to cancel momentum immediately afterwards)
			//Normal hitstun
			if (!_balloon)
				{
				for(var m = 0; m < _stun; m++)
					{
					var _loop = true;
		
					//Hitting the ground
					if (m == 0 && _vsp > 0 && on_ground())
						{
						if (setting().show_launch_trajectories)
							{
							with(instance_create_layer(x, y, layer, obj_launch_trajectory_point))
								{
								image_index = 3;
								}
							}
						_loop = false;
						}
		
					//"Gravity and Friction"
					_hsp = approach(_hsp, 0, air_friction);
					if (_vsp < max_fall_speed) then _vsp = min(_vsp + hitstun_grav, max_fall_speed);
		
					//"Movement"
					x = round(x + _hsp);
					y = round(y + _vsp);
				
					//"Drift DI"
					if (m > drift_di_lockout)
						{
						if (_stickx == sign(_hsp))
							{
							if (abs(_hsp + drift_di_accel * _stickx) < drift_di_max * drift_di_multiplier)
								{
								_hsp += drift_di_accel * _stickx;
								}
							}
						else
							{
							_hsp += drift_di_accel * _stickx;
							}
						}
		
					//Collide with blocks (every other iteration)
					//Do not check for missed tech bouncing
					if (m % 2 == 0 || m == _stun - 1)
						{
						if (collision(x, y, [FLAG.solid]))
							{
							if (setting().show_launch_trajectories)
								{
								with(instance_create_layer(x, y, layer, obj_launch_trajectory_point))
									{
									image_index = 3;
									}
								}
							_loop = false;
							}
						}
					
					//Check blastzones (every fourth iteration)
					if ((m % 4 == 0 || m == _stun - 1) && blastzones_check(true))
						{
						_ko_count++;
						_loop = false;
						}
	
					//Trajectory
					if (setting().show_launch_trajectories && (m % 2 == 0 || m == _stun - 1))
						{
						with(instance_create_layer(x, y, layer, obj_launch_trajectory_point))
							{
							if (_stickx == _facing) then image_blend = c_blue;
							if (_stickx == -_facing) then image_blend = c_red;
							if (m == 0)
								{
								image_index = 2;
								}
							else if (m == _stun - 1)
								{
								image_index = 1;
								}
							}
						}
			
					//Break out of loop
					if (!_loop) then break;
					}
				}
			//Balloon hitstun
			else
				{
				var _state_phase = 0;
				var _state_time = 0;
				//The m counter is incremented inside the loop
				var m = 0;
				while(m < _stun)
					{
					var _loop = true;
					var _current_speed = point_distance(0, 0, _hsp, _vsp);
					_state_time++;
		
					//Hitting the ground
					if (m == 0 && _vsp > 0 && on_ground())
						{
						if (setting().show_launch_trajectories)
							{
							with(instance_create_layer(x, y, layer, obj_launch_trajectory_point))
								{
								image_index = 3;
								}
							}
						_loop = false;
						}
					
					//"Drift DI"
					if (m > drift_di_lockout)
						{
						if (_stickx == sign(_hsp))
							{
							if (abs(_hsp + drift_di_accel * _stickx) < drift_di_max * drift_di_multiplier)
								{
								_hsp += drift_di_accel * _stickx;
								}
							}
						else
							{
							_hsp += drift_di_accel * _stickx;
							}
						}
					
					//Balloon knockback
					//Calculate the number of times the player moves
					var _times = 1;
					if (_stun - m <= balloon_upper_frame)
						{
						_times = 1;
						}
					else if (_state_phase == 0)
						{
						if (_state_time <= balloon_lower_frame ||
							_current_speed >= balloon_speed_threshold)
							{
							_times = 2;
							}
						else
							{
							//Once a player slows down under the threshold, they cannot have doubled knockback even if they speed up again
							_state_phase = 1;
							}
						}
						
					repeat(_times)
						{
						//"Gravity and Friction"
						_hsp = approach(_hsp, 0, air_friction);
						if (_vsp < max_fall_speed) then _vsp = min(_vsp + hitstun_grav, max_fall_speed);
		
						//"Movement"
						x = round(x + _hsp);
						y = round(y + _vsp);
		
						//Collide with blocks (every other iteration)
						//Do not check for missed tech bouncing
						if (m % 2 == 0 || m == _stun - 1)
							{
							if (collision(x, y, [FLAG.solid]))
								{
								if (setting().show_launch_trajectories)
									{
									with(instance_create_layer(x, y, layer, obj_launch_trajectory_point))
										{
										image_index = 3;
										}
									}
								_loop = false;
								}
							}
						
						//Check blastzones (every fourth iteration)
						if ((m % 4 == 0 || m == _stun - 1) && blastzones_check(true))
							{
							_ko_count++;
							_loop = false;
							}
	
						//Trajectory
						if (setting().show_launch_trajectories && (m % 2 == 0 || m == _stun - 1))
							{
							with(instance_create_layer(x, y, layer, obj_launch_trajectory_point))
								{
								if (_stickx == _facing) then image_blend = c_blue;
								if (_stickx == -_facing) then image_blend = c_red;
								if (m == 0)
									{
									image_index = 2;
									}
								else if (m == _stun - 1)
									{
									image_index = 1;
									}
								}
							}
						
						//Increment
						m++;
						}
					
					//Break out of loop
					if (!_loop) then break;
					}
				}
			}
		}
	
	//Reset position
	x = _tx;
	y = _ty;
	
	if (_ko_count == 3) then return true;

	return false;
}
/* Copyright 2023 Springroll Games / Yosi */