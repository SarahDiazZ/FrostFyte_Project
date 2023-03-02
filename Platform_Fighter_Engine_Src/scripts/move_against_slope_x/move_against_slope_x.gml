///@category Collisions
///@param {int} hsp		The horizontal speed
/*
Attempts to move a player up a slope. Returns true if the player is moved up a slope. If there is no slope, or the player cannot move up the slope, it returns false.
This function meant to be used in other collision functions and should not be called independently.
*/
function move_against_slope_x() {
	//Make sure slopes are enable
	if (!setting().slope_collisions_enable) then return false;
	
	var _h = sign(argument[0]);
	var _slope = collision(x + _h, y, [FLAG.slope]);
	
	//If the slope exists and is pointed in the correct direction
	if (_slope != noone && sign(_slope.image_xscale) == _h) 
		{
		//If the slope moves up
		if (sign(_slope.image_yscale) == 1 && (_slope.bbox_bottom - 1) >= (bbox_bottom - 1)) 
			{
			//Checks collisions for any slope
			var _start_y = y;
			while(collision(x + _h, y, [FLAG.slope]) && !collision(x, y - 1, [FLAG.solid])) 
				{
				y -= 1;
				}
			
			//Reduce the number of times you can move
			if (slope_change_speed)
				{
				hsp_moved += (1 / abs(dcos(_slope.slope_angle))) - 1;
				}
			
			if (!collision(x + _h, y, [FLAG.solid])) 
				{
				x += _h;
				return true;
				}
			else
				{
				y = _start_y;
				}
			}
		//If the slope moves down
		else if (sign(_slope.image_yscale) == -1 && _slope.bbox_top <= bbox_top) 
			{
			//Macro for not getting pushed down by horizontal slopes
			if (!slope_horizontal_pushes_down) then return true;
		
			var _start_y = y;
			while(collision(x + _h, y, [FLAG.slope]) && !collision(x, y + 1, [FLAG.solid])) 
				{
				y += 1;
				}
			
			//Reduce the number of times you can move
			if (slope_change_speed)
				{
				hsp_moved += (1 / abs(dcos(_slope.slope_angle))) - 1;
				}	
			
			if (!collision(x + _h, y, [FLAG.solid])) 
				{
				x += _h;
				return true;
				}
			else
				{
				y = _start_y;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */