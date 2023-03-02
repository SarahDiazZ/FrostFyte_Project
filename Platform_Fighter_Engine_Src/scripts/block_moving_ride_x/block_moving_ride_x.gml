///@category Collisions
///@param {array} ride_array		The array of instances that are riding on the block
///@param {int} dir					Either -1 for left, or 1 for right
///@param {int} [recursion]			The level of recursion. Do not set this argument
/*
To be used by child objects of <obj_block_moving>.
Moves all of the instances in the array horizontally based on the direction specified.
If <block_moving_recursion> is not zero, all instances riding on the block will also calculate riding and pushing.
*/
function block_moving_ride_x() {
	var _a = argument[0];
	var _d = argument[1];
	var _r = argument_count > 2 ? argument[2] : 0;
	var _l = array_length(_a);
	
	if (block_moving_recursion == 0)
		{
		for(var m = 0; m < _l; m++)
			{
			with(_a[@ m])
				{
				nudge_x(_d);
				}
			}
		}
	else if (_r <= block_moving_recursion)
		{
		for(var m = 0; m < _l; m++)
			{
			with(_a[@ m])
				{
				var _ride_array = block_moving_find_riders();
				
				nudge_x(_d);
				
				if (collision_flag_exists(id, FLAG.solid))
					{
					block_moving_ride_x(_ride_array, _d, _r + 1);
					block_moving_push_x(_d, _r + 1);
					}
				else if (collision_flag_exists(id, FLAG.plat))
					{
					block_moving_ride_x(_ride_array, _d, _r + 1);
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */