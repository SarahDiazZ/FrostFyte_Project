///@category Player Actions
///@param {real} [strength]			The strength of the jostle push
///@param {int} [type]				The type of jostle
/*
Allows the player to push away other players that are overlapping with their collision box.
The specifics will depends on the jostle type given:
	- Gradual : Players will be accelerated away from other players. Players can still walk and run through other players.
	- Instance : Players will be moved to a position where they are no longer overlapping. Players cannot move through each other.
*/
function jostle_players() {
	var _s = argument_count > 1 ? argument[1] : jostle_strength;
	var _t = argument_count > 0 ? argument[0] : jostle_type_default;

	//Push away other players
	with(obj_player)
		{
		if (id == other.id) then continue;
	
		//Make sure the player is in a state that can be jostled
		if (!array_contains(jostle_states, state)) then continue;
	
		//Check that the players are overlapping
		if (!place_meeting(x, y, other.id)) then continue;
		
		if (_t == JOSTLE_TYPE.gradual)
			{
			var _diff = sign(x - other.x);
			//Default push direction
			if (_diff == 0) then _diff = other.facing;
			//Push the opponent
			move_x_grounded(sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index), _s * _diff);
			}
		else if (_t == JOSTLE_TYPE.instant)
			{
			var _diff = sign(x - other.x);
			//Default push direction
			if (_diff == 0) then _diff = other.facing;
			//Push the opponent
			var _spd = (abs(other.hsp) != 0 ? abs(other.hsp) : 1) * _s * _diff;
			move_x_grounded(sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index), _spd);
			
			//Move until you no longer overlap the opponent
			with(other)
				{
				if (place_meeting(x, y, other.id))
					{
					var _amount = (_diff == 1)
						? other.bbox_left - (bbox_right - 1)
						: (other.bbox_right - 1) - bbox_left;
					move_x_grounded(sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index), _amount);
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */