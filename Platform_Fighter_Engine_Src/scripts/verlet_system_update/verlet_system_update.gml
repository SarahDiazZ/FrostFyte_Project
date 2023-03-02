///@category Verlet
///@param {id} system		The id of the system to update
/*
Advances the given verlet physics system by 1 frame, moving all points and sticks.
*/
function verlet_system_update() {
	assert(instance_exists(argument[0]), "[verlet_system_update] The given system ", argument[0], " does not exist!");
	with(argument[0])
		{
		//Update all points
		var _num = array_length(verlet_points);
		var _custom = (verlet_move_script != -1 && script_exists(verlet_move_script));
		var _air_resist = verlet_air_resist;
		var _grav_x = verlet_grav_x;
		var _grav_y = verlet_grav_y;
		var _bounce = verlet_bounce_multiplier;
		var _move_script = verlet_move_script;
		for(var i = 0; i < _num; i++)
			{
			with(verlet_points[@ i])
				{
				var _vx = x - xprev;
				var _vy = y - yprev;
				
				//Forces
				_vx -= clamp(_vx, -_air_resist,_air_resist);
				_vy -= clamp(_vy, -_air_resist,_air_resist);
				_vx += _grav_x;
				_vy += _grav_y;
				
				//Update previous positions
				xprev = x;
				yprev = y;
			
				//Custom movement script
				if (_custom)
					{
					script_execute(_move_script, _vx, _vy, _bounce);
					}
				//Auto movement
				else
					{
					verlet_point_move_auto(_vx, _vy, _bounce);
					}
				}
			}
			
		//Update all sticks
		var _num = array_length(verlet_sticks);
		var _strength = verlet_sticks_strength_multiplier;
		repeat(verlet_sticks_iterations)
			{
			for(var i = 0; i < _num; i++)
				{
				with(verlet_sticks[@ i])
					{
					var _dist = point_distance(point1.x, point1.y, point2.x, point2.y);
					var _rigid = (object_index == obj_verlet_stick_rigid);
					if ((_rigid && _dist != length) || _dist > length)
						{
						//Move the points inward
						var _diff_x = point1.x - point2.x;
						var _diff_y = point1.y - point2.y;
						var _pull = (((_dist - length) / _dist) / 2.0);
						if (!_rigid) then _pull *= _strength;
						var _move_x = _diff_x * _pull;
						var _move_y = _diff_y * _pull;
						//Custom movement script
						if (_custom)
							{
							with(point1) script_execute(_move_script, -_move_x, -_move_y, _bounce);
							with(point2) script_execute(_move_script, _move_x, _move_y, _bounce);
							}
						//Auto movement
						else
							{
							with(point1) verlet_point_move_auto(-_move_x, -_move_y, _bounce);
							with(point2) verlet_point_move_auto(_move_x, _move_y, _bounce);
							}
						}
					}
				}
			}
		}
}

/* Copyright 2023 Springroll Games / Yosi */