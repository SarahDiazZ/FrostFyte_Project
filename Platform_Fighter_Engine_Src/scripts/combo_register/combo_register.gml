///@category Attacking
///@param {id} attacker		The player attacking
///@param {id} target		The player being hit
/*
Checks if the player being hit is being comboed, and changes the combo counter accordingly.
If <show_combos> is turned on, this function will create the text.
*/
function combo_register() {
	var _attacker = argument[0];
	var _target = argument[1];
	
	with(_attacker)
		{
		//Don't count combos for non-player objects
		if (object_index != obj_player) then return false;
		
		if (combo_target != _target)
			{
			combo_target = _target;
			combo_counter = 0;
			}
		
		if (_target.state == PLAYER_STATE.balloon ||
			_target.state == PLAYER_STATE.flinch ||
			_target.state == PLAYER_STATE.hitlag ||
			_target.state == PLAYER_STATE.hitstun ||
			_target.state == PLAYER_STATE.is_grabbed ||
			_target.state == PLAYER_STATE.knockdown ||
			_target.state == PLAYER_STATE.magnetized)
			{
			combo_counter++;
			}
		else
			{
			combo_counter = 1;
			}
		
		combo_break_timer = 0;
		
		return combo_counter;
		}
	return undefined;
}
/* Copyright 2023 Springroll Games / Yosi */