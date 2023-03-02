///@category Control Stick
///@param {int} stick					Either <Lstick> or <Rstick>
///@param {real/array} direction		The motion direction(s) to check for, from the DIR_M enum
///@param {int} [frame]					The frame to check on
/*
Returns true if the stick was tilted in the given motion direction on the given frame.
If an array of directions is given, it returns true if the stick was tilted in ANY of the given directions on the given frame.
Motion directions must be from the DIR_M enum (or the integer values of the enum entries), and they are relative to the way the player is facing.
By default, it checks frame 0, the current frame.
The threshold for directions is determined by the <stick_direction_motion_sens>.
*/
function stick_direction_motion() {
	var _stick = argument[0];
	var _directions = argument[1];
	var _frame = argument_count > 2 ? argument[2] : 0;
	var _stick_dir = stick_get_direction(_stick, _frame);
	
	//Change stick direction to be relative to the player's facing direction
	if (facing == -1)
		{
		_stick_dir = 180 - _stick_dir;
		}
		
	//Check if the stick was tilted
	var _tilted = (_stick == Lstick)
		? stick_get_distance(_stick, _frame) > stick_tilt_amount
		: stick_get_distance(_stick, _frame) > rstick_tilt_amount;
	
	//Loop
	if (!is_array(_directions)) then _directions = [_directions];
	
	for(var i = 0; i < array_length(_directions); i++)
		{
		var _dir = _directions[@ i];
		
		//Any
		if (_dir == DIR_M.any) then return true;
	
		//Neutral
		if (_dir == DIR_M.neutral)
			{
			if (!_tilted)
				{
				return true;
				}
			continue;
			}
	
		//All other directions
		if (!_tilted) then continue;
	
		switch(_dir)
		    {
		    case DIR_M.down_back:
		        if (abs(angle_difference(225, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    case DIR_M.down:
		        if (abs(angle_difference(270, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    case DIR_M.down_front:
		        if (abs(angle_difference(315, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    case DIR_M.back:
		        if (abs(angle_difference(180, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    case DIR_M.front:
		        if (abs(angle_difference(0, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    case DIR_M.up_back:
		        if (abs(angle_difference(135, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    case DIR_M.up:
		        if (abs(angle_difference(90, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    case DIR_M.up_front:
		        if (abs(angle_difference(45, _stick_dir)) < stick_direction_motion_sens) then return true;
		        break;
		    default: crash("[stick_direction_motion] Direction is invalid (", _dir, ")"); break;
		    }
		}
    return false;
}
/* Copyright 2023 Springroll Games / Yosi */