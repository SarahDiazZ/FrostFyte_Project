///@category Collisions
///@param {int} edge_buffer			How far away a player can be from the edge before stopping
///@param {int} hsp					The horizontal speed
///@param {bool} [lock_hsp]			Whether to prevent the hsp from changing or not
///@param {bool} [extra_precise]	Whether the collision checking should be more intensive
/*
Moves the player horizontally the given amount, and stops at edges.
If no hsp is specified, it moves based on the player's hsp variable.
If the player is already closer to the ledge than the edge buffer, they will NOT be moved back.
If lock_hsp is true, the player's hsp variable will not be affected by this function.
If extra_precise is true, more collision checks will be performed to make the function more precise, at the cost of performance.
Please note: This function meant to be used in other collision functions and should not be called independently.
*/
function move_x_grounded() {
	var _edge_buffer = argument[0];
	var _hsp = argument_count > 1 ? argument[1] : hsp;
	var _lock = argument_count > 2 ? argument[2] : false;
	var _extra_precise = argument_count > 3 ? argument[3] : false;
	var _dir = sign(_hsp);
	
	//Exit out early if the hsp is set to 0
	if (_hsp == 0)
		{
		return;
		}
	
	//Initial check
	var _store_x = x;
	var _store_y = y;
	var _future_x;
	var _future_y;
	
	move_x(_edge_buffer * _dir, true);
	
	//Store the future position and move back
	_future_x = x;
	_future_y = y;
	x = _store_x;
	y = _store_y;
		
	//If moving the player ahead by the edge buffer would cause them to move off the ground, don't move at all
	if (!on_ground(_future_x, _future_y))
		{
		return;
		}
		
	//Move pixel by pixel
	for(hsp_moved = 0; hsp_moved < abs(_hsp); hsp_moved++)
		{
		//Save player variables
		var _hsp_moved = hsp_moved;
		_store_x = x;
		_store_y = y;
		
		//Check the player's actual position (only if precise ground movement is set)
		//There's an edge case where the future position is on ground, but the current position is not. This covers that edge case somewhat, but costs performance.
		if (_extra_precise)
			{
			move_x(_dir, true);
			if (!on_ground())
				{
				//Move back, and exit the function
				x = _store_x;
				y = _store_y;
				return;
				}
			}
			
		//Check the player's future position (actual position + edge buffer)
		x = _future_x;
		y = _future_y;
		move_x(_dir, true);
		_future_x = x;
		_future_y = y;
		if (!on_ground())
			{
			//Move back, and exit the function
			x = _store_x;
			y = _store_y;
			return;
			}
			
		//If the player will stay on the ground no matter what, we can move
		x = _store_x;
		y = _store_y;
		if (!collision(x + _dir, y, [FLAG.solid]))
			{
			//Go down slopes
			if (move_with_slope_x(_hsp))
				{
				//Successfully move down the slope
				}
			else
				{
				//Move normally
				x += _dir;
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
				//Hitting a wall exits the function
				if (!_lock)
					{
					hsp_frac = 0;
					hsp = 0;
					}
				return;
				}
			}
		
		//Set the loop variable back
		hsp_moved = _hsp_moved;
		}
}
/* Copyright 2023 Springroll Games / Yosi */