///@description <Run by obj_game>

//Background Clear
background_clear_frame = max(--background_clear_frame, 0);
if (background_clear_frame == 0)
	{
	background_clear_amount = max(0, background_clear_amount - 0.1);
	}
else
	{
	background_clear_amount = min(1, background_clear_amount + background_clear_fade_speed);
	}
	
//Background update
for(var i = 0; i < array_length(background); i++)
	{
	var _layer = background[@ i];
	
	if (_layer[@ BACK.sprite] != -1)
		{
		if (_layer[@ BACK.xspd] != 0 || _layer[@ BACK.yspd] != 0)
			{
			_layer[@ BACK.x] += _layer[@ BACK.xspd];
			_layer[@ BACK.y] += _layer[@ BACK.yspd];
		
			//Wrapping around
			if (_layer[@ BACK.xspd] > 0 && _layer[@ BACK.x] > room_width)
				{
				_layer[@ BACK.x] -= room_width + (sprite_get_width(_layer[@ BACK.sprite]) * _layer[@ BACK.scale]);
				}
			if (_layer[@ BACK.xspd] < 0 && _layer[@ BACK.x] < 0)
				{
				_layer[@ BACK.x] += room_width + (sprite_get_width(_layer[@ BACK.sprite]) * _layer[@ BACK.scale]);
				}
			if (_layer[@ BACK.yspd] > 0 && _layer[@ BACK.y] > room_height)
				{
				_layer[@ BACK.y] -= room_height + (sprite_get_height(_layer[@ BACK.sprite]) * _layer[@ BACK.scale]);
				}
			if (_layer[@ BACK.yspd] < 0 && _layer[@ BACK.y] < 0)
				{
				_layer[@ BACK.y] += room_height + (sprite_get_height(_layer[@ BACK.sprite]) * _layer[@ BACK.scale]);
				}
			}
		
		var _num = sprite_get_number(_layer[@ BACK.sprite]);
		if (_num > 0)
			{
			_layer[@ BACK.frame] += _layer[@ BACK.imgspeed];
			if (_layer[@ BACK.frame] >= _num)
				{
				_layer[@ BACK.frame] -= _num;
				}
			}
		}
	}

//Background fog
background_fog_alpha = lerp(background_fog_alpha, 0, 0.1);
if (background_fog_alpha < 0.01)
	{
	background_fog_alpha = 0;
	}
	
//Run the stage script
if (stage_script != -1) then script_execute(stage_script);
/* Copyright 2023 Springroll Games / Yosi */