function stage_smiley_floats_script() {
	if (obj_game.state == GAME_STATE.startup) then return;
	
	custom_stage_struct.timer += 1;
	var _t = custom_stage_struct.timer / 60;
	var _p = 0;
	
	//Move around platforms
	if (_t < 5)
		{
		//Reset platform locations
		with(obj_smiley_floats_block)
			{
			x = start_x;
			y = start_y;
			custom_block_moving_struct.new_x = start_x;
			custom_block_moving_struct.new_y = start_y;
			}
		}
	else if (_t < 15)
		{
		_p = (_t - 5) / 10;
		//Move first platform down
		with(custom_ids_struct.float_ids[@ 0])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 1200, _p);
			}
		with(custom_ids_struct.float_ids[@ 1])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 1200, _p);
			}
		with(custom_ids_struct.float_ids[@ 2])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 1200, _p);
			}
		//Move the second platform in
		with(custom_ids_struct.float_ids[@ 3])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 222, _p);
			custom_block_moving_struct.new_y = lerp(start_y, 478, _p);
			}
		}
	else if (_t < 25)
		{
		_p = (_t - 15) / 10;
		//Move the second platform up and down
		with(custom_ids_struct.float_ids[@ 3])
			{
			custom_block_moving_struct.new_y = 478 + (dsin(_p * 360) * 30);
			}
		}
	else if (_t < 30)
		{
		_p = (_t - 25) / 5;
		//Move the second platform out
		with(custom_ids_struct.float_ids[@ 3])
			{
			custom_block_moving_struct.new_x = lerp(222, start_x, _p);
			custom_block_moving_struct.new_y = lerp(478, 600, _p);
			}
		//Move the third platform up
		with(custom_ids_struct.float_ids[@ 4])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 512, _p);
			}
		with(custom_ids_struct.float_ids[@ 5])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 576, _p);
			}
		}
	else if (_t < 35)
		{
		_p = (_t - 30) / 5;
		//Move the fourth platform across
		with(custom_ids_struct.float_ids[@ 6])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 640, _p);
			custom_block_moving_struct.new_y = start_y + lerp(0, 40, _p);
			}
		with(custom_ids_struct.float_ids[@ 7])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 448, _p);
			custom_block_moving_struct.new_y = start_y + lerp(0, 35, _p);
			}
		}
	else if (_t < 45)
		{
		_p = (_t - 35) / 10;
		//Move the fourth platform out
		with(custom_ids_struct.float_ids[@ 6])
			{
			custom_block_moving_struct.new_x = lerp(640, 1768, _p);
			custom_block_moving_struct.new_y = start_y + lerp(40, -20, _p);
			}
		with(custom_ids_struct.float_ids[@ 7])
			{
			custom_block_moving_struct.new_x = lerp(448, 1576, _p);
			custom_block_moving_struct.new_y = start_y + lerp(35, -20, _p);
			}
		//Move the third platform up
		with(custom_ids_struct.float_ids[@ 4])
			{
			custom_block_moving_struct.new_x = start_x + lerp(0, -40, _p);
			custom_block_moving_struct.new_y = lerp(512, -288, _p);
			}
		with(custom_ids_struct.float_ids[@ 5])
			{
			custom_block_moving_struct.new_x = start_x + lerp(0, -40, _p);
			custom_block_moving_struct.new_y = lerp(576, -224, _p);
			}
		//Move the fifth platform in
		with(custom_ids_struct.float_ids[@ 8])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 640, _p);
			custom_block_moving_struct.new_y = lerp(start_y, 512, _p);
			}
		//Move the sixth platform right
		with(custom_ids_struct.float_ids[@ 9])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 32, _p);
			custom_block_moving_struct.new_y = lerp(start_y, 576, _p);
			}
		with(custom_ids_struct.float_ids[@ 10])
			{
			custom_block_moving_struct.new_x = lerp(start_x, -32, _p);
			custom_block_moving_struct.new_y = lerp(start_y, 608, _p);
			}
		}
	else if (_t < 55)
		{
		_p = (_t - 45) / 10;
		//Move the fifth platform up
		with(custom_ids_struct.float_ids[@ 8])
			{
			custom_block_moving_struct.new_x = lerp(640, 704, _p);
			custom_block_moving_struct.new_y = lerp(512, -320, _p);
			}
		//Move the sixth platform right
		with(custom_ids_struct.float_ids[@ 9])
			{
			custom_block_moving_struct.new_x = lerp(32, 608, _p);
			custom_block_moving_struct.new_y = lerp(576, 480, _p);
			}
		with(custom_ids_struct.float_ids[@ 10])
			{
			custom_block_moving_struct.new_x = lerp(-32, 224, _p);
			custom_block_moving_struct.new_y = lerp(608, 544, _p);
			}
		}
	else if (_t < 65)
		{
		_p = (_t - 55) / 10;
		//Move the sixth platform right
		with(custom_ids_struct.float_ids[@ 9])
			{
			custom_block_moving_struct.new_x = lerp(608, 1344, _p);
			}
		with(custom_ids_struct.float_ids[@ 10])
			{
			custom_block_moving_struct.new_x = lerp(224, 1280, _p);
			}
		//Move the seventh platform left
		with(custom_ids_struct.float_ids[@ 11])
			{
			custom_block_moving_struct.new_x = start_x + lerp(0, -2500, _p);
			}
		with(custom_ids_struct.float_ids[@ 12])
			{
			custom_block_moving_struct.new_x = start_x + lerp(0, -2500, _p);
			}
		with(custom_ids_struct.float_ids[@ 13])
			{
			custom_block_moving_struct.new_x = start_x + lerp(0, -2500, _p);
			}
		//Move the eighth platform in
		with(custom_ids_struct.float_ids[@ 14])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 736, _p);
			custom_block_moving_struct.new_y = lerp(start_y, 320, _p);
			}
		}
	else if (_t < 70)
		{
		_p = (_t - 65) / 5;
		//Move the eighth platform down
		with(custom_ids_struct.float_ids[@ 14])
			{
			custom_block_moving_struct.new_x = lerp(736, 700, _p);
			custom_block_moving_struct.new_y = lerp(320, 400, _p);
			}
		//Move the ninth platform up
		with(custom_ids_struct.float_ids[@ 15])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 320, _p);
			}
		with(custom_ids_struct.float_ids[@ 16])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 352, _p);
			}
		with(custom_ids_struct.float_ids[@ 17])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 224, _p);
			}
		}
	else if (_t < 75)
		{
		_p = (_t - 70) / 5;
		//Move the eighth platform up
		with(custom_ids_struct.float_ids[@ 14])
			{
			custom_block_moving_struct.new_x = lerp(700, 740, _p);
			custom_block_moving_struct.new_y = lerp(400, 200, _p);
			}
		//Move the ninth platform up
		with(custom_ids_struct.float_ids[@ 15])
			{
			custom_block_moving_struct.new_y = lerp(320, -448, _p);
			}
		with(custom_ids_struct.float_ids[@ 16])
			{
			custom_block_moving_struct.new_y = lerp(352, -416, _p);
			}
		with(custom_ids_struct.float_ids[@ 17])
			{
			custom_block_moving_struct.new_y = lerp(224, -544, _p);
			}
		//Move the tenth platform up
		with(custom_ids_struct.float_ids[@ 18])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 480, _p);
			}
		}
	else if (_t < 85)
		{
		_p = (_t - 75) / 10;
		//Move the eighth platform up and down
		with(custom_ids_struct.float_ids[@ 14])
			{
			custom_block_moving_struct.new_y = lerp(200, 250, _p) + (dsin(_p * 360) * 20);
			}
		//Move the tenth platform up and down
		with(custom_ids_struct.float_ids[@ 18])
			{
			custom_block_moving_struct.new_y = 480 + (dsin(_p * 360) * 20);
			}
		}
	else if (_t < 90)
		{
		_p = (_t - 85) / 5;
		//Move the tenth platform down
		with(custom_ids_struct.float_ids[@ 18])
			{
			custom_block_moving_struct.new_y = lerp(480, start_y, _p);
			}
		//Move the eighth platform up to the left
		with(custom_ids_struct.float_ids[@ 14])
			{
			custom_block_moving_struct.new_x = lerp(740, 250, _p);
			}
		}
	else if (_t < 91)
		{
		_p = (_t - 90) / 1;
		//Move the eleventh platform left
		with(custom_ids_struct.float_ids[@ 19])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 864, _p);
			}
		}
	else if (_t < 92)
		{
		//Nothing
		}
	else if (_t < 93)
		{
		_p = (_t - 92) / 1;
		//Move the eleventh platform right (quickly)
		with(custom_ids_struct.float_ids[@ 19])
			{
			custom_block_moving_struct.new_x = lerp(x, start_x, _p);
			}
		}
	else if (_t < 100)
		{
		_p = (_t - 93) / 7;
		//Move the eleventh platform back in
		with(custom_ids_struct.float_ids[@ 19])
			{
			custom_block_moving_struct.new_x = lerp(start_x, 608, _p);
			}
		//Move the eighth platform out
		with(custom_ids_struct.float_ids[@ 14])
			{
			custom_block_moving_struct.new_x = lerp(250, 1300, _p);
			}
		//Move the twelfth platform up
		with(custom_ids_struct.float_ids[@ 20])
			{
			custom_block_moving_struct.new_y = lerp(start_y, 512, _p);
			}
		}
	else if (_t < 120)
		{
		_p = (_t - 100) / 20;
		//Bouncing twelfth platform
		with(custom_ids_struct.float_ids[@ 20])
			{
			var _amount = modulo((_p * 360 * 2), 90) - 45;
			custom_block_moving_struct.new_y = 681 + dcos(_amount) * -240;
			//681 is from 512 - (dcos(45) * -240)
			}
		}
	else if (_t < 125)
		{
		_p = (_t - 120) / 5;
		//Move the twelfth platform back down
		with(custom_ids_struct.float_ids[@ 20])
			{
			custom_block_moving_struct.new_y = lerp(512, start_y, _p);
			}
		//Move the eleventh platform back out
		with(custom_ids_struct.float_ids[@ 19])
			{
			custom_block_moving_struct.new_x = lerp(608, start_x, _p);
			}
		//Move the thirteenth platform up
		with(custom_ids_struct.float_ids[@ 21])
			{
			custom_block_moving_struct.new_y = lerp(800, 512, _p);
			}
		//Move the fourteenth platform into position
		with(custom_ids_struct.float_ids[@ 22])
			{
			y = 224;
			custom_block_moving_struct.new_y = y;
			}
		//Move the fifteenth platform into position
		with(custom_ids_struct.float_ids[@ 23])
			{
			y = 416;
			custom_block_moving_struct.new_y = y;
			}
		}
	else if (_t < 130)
		{
		_p = (_t - 125) / 5;
		//Move the fourteenth platform across
		with(custom_ids_struct.float_ids[@ 22])
			{
			custom_block_moving_struct.new_x = x - 3;
			if (x < -400)
				{
				x = room_width + 100;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 224 + dcos(x) * 15;
			}
		//Move the fifteenth platform across
		with(custom_ids_struct.float_ids[@ 23])
			{
			custom_block_moving_struct.new_x = x + 3;
			if (x > room_width + 100)
				{
				x = -400;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 416 + dcos(x) * 15;
			}
		}
	else if (_t < 135)
		{
		_p = (_t - 130) / 5;
		//Move the thirteenth platform down
		with(custom_ids_struct.float_ids[@ 21])
			{
			custom_block_moving_struct.new_y = lerp(512, 800, _p);
			}
		//Move the fourteenth platform across
		with(custom_ids_struct.float_ids[@ 22])
			{
			custom_block_moving_struct.new_x = x - 3;
			if (x < -400)
				{
				x = room_width + 100;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 224 + dcos(x) * 15;
			}
		//Move the fifteenth platform across
		with(custom_ids_struct.float_ids[@ 23])
			{
			custom_block_moving_struct.new_x = x + 3;
			if (x > room_width + 100)
				{
				x = -400;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 416 + dcos(x) * 15;
			}
		}
	else if (_t < 140)
		{
		_p = (_t - 135) / 5;
		//Move the thirteenth platform up
		with(custom_ids_struct.float_ids[@ 21])
			{
			x = 256;
			custom_block_moving_struct.new_x = x;
			custom_block_moving_struct.new_y = lerp(800, 512, _p);
			}
		//Move the fourteenth platform across
		with(custom_ids_struct.float_ids[@ 22])
			{
			custom_block_moving_struct.new_x = x - 3;
			if (x < -400)
				{
				x = room_width + 100;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 224 + dcos(x) * 15;
			}
		//Move the fifteenth platform across
		with(custom_ids_struct.float_ids[@ 23])
			{
			custom_block_moving_struct.new_x = x + 3;
			if (x > room_width + 100)
				{
				x = -400;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 416 + dcos(x) * 15;
			}
		}
	else if (_t < 160)
		{
		//Move the fourteenth platform across
		with(custom_ids_struct.float_ids[@ 22])
			{
			custom_block_moving_struct.new_x = x - 3;
			if (x < -400)
				{
				x = room_width + 100;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 224 + dcos(x) * 15;
			}
		//Move the fifteenth platform across
		with(custom_ids_struct.float_ids[@ 23])
			{
			custom_block_moving_struct.new_x = x + 3;
			if (x > room_width + 100)
				{
				x = -400;
				custom_block_moving_struct.new_x = x;
				}
			custom_block_moving_struct.new_y = 416 + dcos(x) * 15;
			}
		}
	else if (_t < 180)
		{
		_p = (_t - 160) / 20;
		//Move the fourteenth platform down
		with(custom_ids_struct.float_ids[@ 22])
			{
			custom_block_moving_struct.new_y = y + 2;
			}
		//Move the fifteenth platform down
		with(custom_ids_struct.float_ids[@ 23])
			{
			custom_block_moving_struct.new_y = y + 2;
			}
		//Move the thirteenth platform down
		with(custom_ids_struct.float_ids[@ 21])
			{
			custom_block_moving_struct.new_y = lerp(512, 800, _p);
			}
		//Move first platform up
		with(custom_ids_struct.float_ids[@ 0])
			{
			custom_block_moving_struct.new_y = lerp(1000, start_y, _p);
			}
		with(custom_ids_struct.float_ids[@ 1])
			{
			custom_block_moving_struct.new_y = lerp(1000, start_y, _p);
			}
		with(custom_ids_struct.float_ids[@ 2])
			{
			custom_block_moving_struct.new_y = lerp(1000, start_y, _p);
			}
		}
	else
		{
		custom_stage_struct.timer = 0;
		}
}
/* Copyright 2023 Springroll Games / Yosi */