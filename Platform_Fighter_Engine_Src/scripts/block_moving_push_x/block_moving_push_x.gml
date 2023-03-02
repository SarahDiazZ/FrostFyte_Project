///@category Collisions
///@param {int} dir				Either -1 for left, or 1 for right
///@param {int} [recursion]		The level of recursion. Do not set this argument
/*
To be used by child objects of <obj_block_moving>.
Pushes all instances of <obj_collidable> that are overlapping the block horizontally based on the direction specified.
If <block_moving_recursion> is not zero, all instances pushed by the block will also calculate riding and pushing.
*/
function block_moving_push_x() {
	var _d = argument[0];
	var _r = argument_count > 1 ? argument[1] : 0;
	var _pre_flag = collision_flag_exists(id, FLAG.solid);
	
	collision_flag_set(id, FLAG.solid, false);
	
	if (block_moving_recursion == 0)
		{
		var _push_list = collision(x, y, [FLAG.push], true);
		var _length = array_length(_push_list);
		for(var i = 0; i < _length; i++)
			{
			with(_push_list[@ i])
				{
				nudge_x(_d);
				}
			}
		}
	else if (_r <= block_moving_recursion)
		{
		var _push_list = collision(x, y, [FLAG.push], true);
		var _length = array_length(_push_list);
		for(var i = 0; i < _length; i++)
			{
			with(_push_list[@ i])
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
		
	collision_flag_set(id, FLAG.solid, _pre_flag);
}
/* Copyright 2023 Springroll Games / Yosi */