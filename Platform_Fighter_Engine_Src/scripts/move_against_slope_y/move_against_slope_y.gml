///@category Collisions
///@param {int} vsp		The vertical speed
/*
Attempts to move a player against a slope vertically. Returns true if the player moves without collisions. If there is no slope, or the player cannot move on the slope, it returns false.
This function meant to be used in other collision functions and should not be called independently.
*/
function move_against_slope_y() {
	//Make sure slopes are enable
	if (!setting().slope_collisions_enable) then return false;
	
	var _v = sign(argument[0]);
	var _slope = collision(x, y + _v, [FLAG.slope]);
	
	//If the slope exists and is pointed in the right direction
	if (_slope != noone && sign(_slope.image_yscale) == _v) 
		{
		//If the slope moves right
		if (sign(_slope.image_xscale) == 1 && (_slope.bbox_right - 1) >= (bbox_right - 1)) 
			{
			var _start_x = x;
			while(collision(x, y + _v, [FLAG.slope]) && !collision(x - 1, y, [FLAG.solid])) 
				{
				x -= 1;
				//Reduce the number of times you can move
				if (slope_change_speed)
					{
					vsp_moved += (1 / abs(dsin(_slope.slope_angle))) - 1;
					}
				}
			if (!collision(x, y + _v, [FLAG.solid])) 
				{
				y += _v;
				return true;
				}
			else
				{
				x = _start_x;
				}
			}
		//If the slope moves left
		else if (sign(_slope.image_xscale) == -1 && _slope.bbox_left <= bbox_left) 
			{
			var _start_x = x;
			while(collision(x, y + _v, [FLAG.slope]) && !collision(x + 1, y, [FLAG.solid])) 
				{
				x += 1;
				//Reduce the number of times you can move
				if (slope_change_speed)
					{
					vsp_moved += (1 / abs(dsin(_slope.slope_angle))) - 1;
					}
				}
			if (!collision(x, y + _v, [FLAG.solid])) 
				{
				y += _v;
				return true;
				}
			else
				{
				x = _start_x;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */