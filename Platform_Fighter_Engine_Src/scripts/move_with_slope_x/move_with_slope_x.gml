///@category Collisions
///@param {int} hsp		The horizontal speed
/*
Attempts to move a player down a slope. Returns true if the player is moved down a slope. If there is no slope, or the player cannot move down the slope, it returns false.
This function meant to be used in other collision functions and should not be called independently.
*/
function move_with_slope_x() {
	//Make sure slopes are enable
	if (!setting().slope_collisions_enable) then return false;
	
	var _h = sign(argument[0]);
	var _slope = collision(x, y + 1, [FLAG.slope]);
	
	//If the slope exists and is pointed in the right direction
	if (_slope != noone && sign(_slope.image_xscale) != _h)
		{
		//If the slope moves up
		if (sign(_slope.image_yscale) == 1 && (_slope.bbox_bottom - 1) >= (bbox_bottom - 1)) 
			{
			if (!collision(x + _h, y, [FLAG.solid]))
				{
				x += _h;
				while((bbox_bottom - 1) < (_slope.bbox_bottom - 1))
					{
					if (!collision(x, y + 1, [FLAG.solid]) &&
						!collision(x, y + 1, [FLAG.slope]))
						{
						y += 1;
						}
					else
						{
						break;
						}
					}
				
				//Reduce the number of times you can move
				if (slope_change_speed)
					{
					hsp_moved += (1 / abs(dcos(_slope.slope_angle))) - 1;
					}	
			
				return true;
				}
			} 
		} 
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */