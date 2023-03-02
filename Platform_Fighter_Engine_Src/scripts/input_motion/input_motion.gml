///@category Inputs
///@param {array} directions					An ordered array of directions that the player must press, from the DIR_M enum
///@param {int} [stick]							The control stick to check. The default is <Lstick>
///@param {int} [max_frames]					The maximum number of frames the input can take. The default is <buffer_time_max>
///@param {bool} [ignore_wrong_directions]		Whether to ignore wrong directions in the sequence or not. The default is true
/*
Returns true if the player tilted the control stick in the given sequence of directions over the "max_frames" span of previous frames.
The "max_frames" must from 1 to <buffer_time_max>.
The "directions" array must be from the DIR_M enum (or the integer values of the enum entries), and they are relative to the way the player is facing.
You can include nested arrays to allow multiple directions in a sequence, which makes inputs more forgiving.

Examples:
	input_motion(10, [2, 3, 6]) = Quarter Circle Forward
	input_motion(10, [DIR_M.down, DIR_M.down_front, DIR_M.front]) = Quarter Circle Forward
	input_motion(15, [6, [3, 2, 1], 4]) = Half Circle Backward
	input_motion(15, [6, [1, 2], [3, 6]) = Z Input Forward
*/
function input_motion() {
	var _directions = argument[0];
	var _stick = argument_count > 1 ? argument[1] : Lstick;
	var _max_frames = argument_count > 2 ? argument[2] : buffer_time_max;
	var _ignore_wrong_directions = argument_count > 3 ? argument[3] : true;
	var _direction_current = 0;
	
	//Loop through all of the frames, and try to find the directions in order
	var _all_directions = false;
	for(var i = (_max_frames - 1); i >= 0; i--)
		{
		//See if the stick was tilted in the current direction on this frame
		if (stick_direction_motion(_stick, _directions[@ _direction_current], i))
			{
			_direction_current++;
			if (_direction_current >= array_length(_directions))
				{
				_all_directions = true;
				break;
				}
			}
		//See if the stick is still tilted in the previous direction
		else if (_direction_current > 0)
			{
			if (stick_direction_motion(_stick, _directions[@ _direction_current - 1], i))
				{
				//Repeated direction
				}
			//If not, this is counted as a wrong input
			else
				{
				if (!_ignore_wrong_directions) then return false;
				}
			}
		}
		
	//If all of the directions were performed properly, return true
	if (_all_directions)
		{
		return true;
		}
		
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */