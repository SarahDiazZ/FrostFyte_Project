///@description
if (obj_game.state == GAME_STATE.startup) then exit;

//Move to the next point
if (next_point != noone && instance_exists(next_point))
	{
	time++;
	var _next_x = round(lerp(start_x, next_point.x, time / next_point.travel_time));
	var _next_y = round(lerp(start_y, next_point.y, time / next_point.travel_time));
	var _hsp = (_next_x - x);
	var _vsp = (_next_y - y);
	
	//Add to the array any instances standing on the platform, and not moving upwards
	var _ride_array = block_moving_find_riders();
	
	//Movement
	repeat(abs(_hsp))
		{
		x += sign(_hsp);
		
		//Riding
		block_moving_ride_x(_ride_array, sign(_hsp));
		}
	repeat(abs(_vsp))
		{
		y += sign(_vsp);
		
		//Riding
		block_moving_ride_y(_ride_array, sign(_vsp));
		}

	//Next point
	if (time >= next_point.travel_time)
		{
		x = next_point.x;
		y = next_point.y;
		next_point = next_point.next_point;
		time = 0;
		start_x = x;
		start_y = y;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */