///@category Collisions
///@param {int} [hsp]				The horizontal speed
///@param {bool} [lock_hsp]			Whether to prevent the hsp from changing or not
/*
Moves the player a certain amount horizontally, taking slopes into account. If no speed is given, the player's hsp variable is used.
If lock_hsp is true, the player's hsp variable will not be affected by this function.
Please note: This function meant to be used in other collision functions and should not be called independently.
*/
function move_x() {
	var _hsp = argument_count > 0 ? argument[0] : hsp;
	var _lock = argument_count > 1 ? argument[1] : false;
	
	if (_hsp != 0)
		{
		for(hsp_moved = 0; hsp_moved < abs(_hsp); hsp_moved++)
			{
			//No collision
			if (!collision(x + sign(_hsp), y, [FLAG.solid]))
				{
				//Go down slopes
				if (move_with_slope_x(_hsp))
					{
					//Successfully move down the slope
					}
				else
					{
					//Move normally
					x += sign(_hsp);
					}
				}
			else
				{
				//Go up slopes
				if (move_against_slope_x(_hsp))
					{
					//Successfully moved up the slope
					}
				else
					{
					//Hitting a wall
					if (!_lock)
						{
						hsp_frac = 0;
						hsp = 0;
						}
					break;
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */