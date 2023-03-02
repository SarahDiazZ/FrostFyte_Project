///@category Collisions
///@param {id} [grabbed_id]		The id of the player being grabbed
///@param {real} [speed]		The snap speed
/*
This function will move a grabbed player closer to the set grab_hold_* coordinates.
The speed at which the player moves is determined by the macro <grab_snap_speed>, unless the optional argument is used.
If no specific id is given, the player will use whatever id is stored in their grabbed_id variable.
If the grabbed player has grab_hold_enable equal to false, this function does nothing.
*/
function grab_snap_move() {
	var _grabbed_id = argument_count > 0 ? argument[0] : grabbed_id;
	var _speed = argument_count > 1 ? argument[1] :	grab_snap_speed;
	with(_grabbed_id)
		{
		if (grab_hold_enable && grab_hold_id != noone)
			{
			speed_set_towards_point
				(
				grab_hold_id.x + (grab_hold_x * grab_hold_id.facing),
				grab_hold_id.y + grab_hold_y,
				_speed,
				);
				
			move_through_platforms();
			
			speed_set(0, 0, false, false);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */