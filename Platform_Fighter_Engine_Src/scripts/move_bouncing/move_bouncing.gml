///@category Collisions
/*
Moves the player while allowing bouncing off blocks or teching.
This should only be called in hitstun states.
*/
function move_bouncing() {
	var _spd = point_distance(0, 0, hsp, vsp);
	var _falling = (vsp > 0);
	var _dir = point_direction(0, 0, hsp, vsp);
	var _h = lengthdir_x(1, _dir);
	var _v = lengthdir_y(1, _dir);

	for(var i = 0; i < _spd; i++)
		{
		if (!collision(x + _h, y + _v, [FLAG.solid]) &&
			((_falling && !on_ground()) || !_falling))
			{
			x += _h;
			y += _v;
			}
		else
			{
			var _tx = x;
			var _ty = y;
			x = ceil(_tx);
			y = ceil(_ty);
			
			//Attempt to move players out of blocks if they would snap into one
			if (collision(x, y, [FLAG.solid]))
				{
				x = floor(_tx);
				y = floor(_ty);
				}
		
			var _result = check_tech();
			if (_result == TECH_RESULT.success)
				{
				//Exit out on successful teching
				break;
				}
			else if (_result == TECH_RESULT.slide)
				{
				//Continue moving on a slide
				_falling = (vsp > 0);
				//Choose the smallest distance to move
				_spd = min(_spd, point_distance(0, 0, hsp, vsp));
				_dir = point_direction(0, 0, hsp, vsp);
				_h = lengthdir_x(1, _dir);
				_v = lengthdir_y(1, _dir);
				continue;
				}
			else if (_result == TECH_RESULT.bounce)
				{
				//Continue moving with the new speed and direction
				_spd = point_distance(0, 0, hsp, vsp) - i;
				_falling = (vsp > 0);
				_dir = point_direction(0, 0, hsp, vsp);
				_h = lengthdir_x(1, _dir);
				_v = lengthdir_y(1, _dir);
				continue;
				}
			}
		}

	//Round coordinates
	x = round(x);
	y = round(y);
}
/* Copyright 2023 Springroll Games / Yosi */