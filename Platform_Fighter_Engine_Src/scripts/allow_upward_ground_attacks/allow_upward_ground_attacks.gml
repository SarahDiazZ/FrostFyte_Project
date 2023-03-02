///@category Attacking
/*
Allows a player to use Up Special or Up Smash, and returns true if they do.
*/
function allow_upward_ground_attacks() {
	var _started = false;
	//If the player is on the ground
	if (on_ground())
		{
		if (scs[@ SCS.smash_stick])
			{
			//Up Smash
			if (stick_flicked(Lstick, DIR.up) && input_pressed(INPUT.attack, buffer_time_standard, false))
				{
				_started = attack_start(my_attacks[$ "Usmash"]);
				return _started;
				}
			}
		
		var _stick = stick_choose_by_input(INPUT.smash);
		if (stick_tilted(_stick, DIR.up))
			{
			//Up Smash
			if (input_pressed(INPUT.smash) ||
				(scs[@ SCS.AB_smash] && input_pressed(INPUT.attack, buffer_time_standard, false) && input_pressed(INPUT.special, buffer_time_standard, false)))
				{
				if (_stick == Rstick)
					{
					//Change direction
					var _frame = stick_find_frame(Rstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
					if (_frame == -1) then _frame = 0;
					change_facing(Rstick, _frame);
					}
				else
					{
					change_facing(Lstick);
					}
				_started = attack_start(my_attacks[$ "Usmash"]);
				return _started;
				}
			}
		
		var _stick = stick_choose_by_input(INPUT.special);
		if (stick_tilted(_stick, DIR.up))
			{
			//Up Special
			if (input_pressed(INPUT.special, buffer_time_standard, false))
				{
				if (_stick == Rstick)
					{
					//Change direction
					var _frame = stick_find_frame(Rstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
					if (_frame == -1) then _frame = 0;
					change_facing(Rstick, _frame);
					}
				else
					{
					change_facing(Lstick);
					}
				_started = attack_start(my_attacks[$ "Uspec"]);
				return _started;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */