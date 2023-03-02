///@category Player Actions
///@param {real} distance		The maximum distance the tether reaches
///@param {real} [x]			The x position to measure distance from
///@param {real} [y]			The y position to measure distance from
/*
Allows the player to tether to a distance ledge, and returns true if they do.

Ledge tether conditions:
	- The player cannot be on the opposite side of the ledge
	- The player must be close enough to the ledge
	- The player must be facing the ledge
				
If ledge_type is LEDGE_TYPE.hog:
	- No other players are currently grabbing that ledge
*/
function check_ledge_tether() {
	var _dist = argument[0];
	if (instance_number(obj_ledge) > 0)
		{
		if (ledge_grab_timeout == 0 && (ledge_grab_max == -1 || ledge_grab_counter < ledge_grab_max))
			{
			var _x = argument_count > 1 ? argument[1] : x;
			var _y = argument_count > 2 ? argument[2] : y;
			var _nearest = instance_nearest(_x, _y, obj_ledge);
	
			/*
			Ledge tether conditions:
				The player cannot be on the opposite side of the ledge
				The player cannot have the same x as the ledge
				The player must be close enough to the ledge
				The player must be facing the ledge
				
			If ledge_type is LEDGE_TYPE.hog:
				No other players are currently grabbing that ledge
			*/
	
			if (sign(_nearest.x - _x) != -_nearest.image_xscale && 
				_nearest.x != _x &&
				point_distance(_x, _y, _nearest.x, _nearest.y) < _dist &&
				facing == _nearest.image_xscale)
				{
				//Ledge hogging
				var _can_grab = true;
				if (ledge_type == LEDGE_TYPE.hog)
					{
					with(obj_player)
						{
						if (id != other.id && ledge_id == _nearest &&
							(state == PLAYER_STATE.ledge_snap ||
							state == PLAYER_STATE.ledge_hang ||
							state == PLAYER_STATE.ledge_getup ||
							state == PLAYER_STATE.ledge_attack ||
							state == PLAYER_STATE.ledge_roll ||
							state == PLAYER_STATE.ledge_jump))
							{
							_can_grab = false;
							break;
							}
						}
					}
				
				if (_can_grab)
					{
					state_set(PLAYER_STATE.ledge_tether);
					ledge_id = _nearest;
					facing = _nearest.image_xscale;
					return true;
					}
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */