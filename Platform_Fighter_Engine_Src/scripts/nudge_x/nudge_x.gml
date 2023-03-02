///@category Collisions
///@param {int} dir		Either -1 for left, or 1 for right
/*
Moves the player by 1 pixel either left or right, taking slopes into account.
*/
function nudge_x() {
	var _dir = argument[0];
	
	//No collision
	if (!collision(x + _dir, y, [FLAG.solid]))
		{
		//Go down slopes
		if (move_with_slope_x(_dir))
			{
			//Successfully move down the slope
			return true;
			}
		else
			{
			//Move normally
			x += _dir;
			return true;
			}
		}
	else
		{
		//Go up slopes
		if (move_against_slope_x(_dir))
			{
			//Successfully moved up the slope
			return true;
			}
		else
			{
			//Hitting a wall
			return false;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */