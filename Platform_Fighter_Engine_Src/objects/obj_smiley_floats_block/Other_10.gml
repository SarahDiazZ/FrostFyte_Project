///@description
if (obj_game.state == GAME_STATE.startup) then exit;

//Calculate speeds
var _hsp = (custom_block_moving_struct.new_x - x);
var _vsp = (custom_block_moving_struct.new_y - y);

//Add to the array any instances standing on the platform, and not moving upwards
var _ride_array = block_moving_find_riders();

//Movement
repeat(abs(_hsp))
	{	
	x += sign(_hsp);
		
	//Riding
	block_moving_ride_x(_ride_array, sign(_hsp));
			
	//Pushing
	block_moving_push_x(sign(_hsp));
	}
repeat(abs(_vsp))
	{
	y += sign(_vsp);
		
	//Riding
	block_moving_ride_y(_ride_array, sign(_vsp));
			
	//Pushing
	block_moving_push_y(sign(_vsp));
	}
		
//Move all players out of blocks just in case
if (_hsp != 0 || _vsp != 0)
	{
	with(obj_player)
		{
		move_out_of_blocks(point_direction(0, 0, _hsp, _vsp));
		}
	}
	
//Reset coordinates
custom_block_moving_struct.new_x = x;
custom_block_moving_struct.new_y = y;

//Color - calculate every frame because it isn't saved by rollback
if (image_blend == c_white)
	{
	image_blend = make_color_hsv(modulo(start_x + start_y, 255), 200, 255);
	image_speed = 0;
	image_index = modulo(start_x + start_y, image_number - 1) + 1;
	}

/* Copyright 2023 Springroll Games / Yosi */