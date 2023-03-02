///@category Attacking
/*
Allows a player to start special attacks, and returns true if they do.
*/
function allow_special_attacks() {
	var _started = false;
	//If one stick is set to attack it overrides the direction of the other stick
	var _stick = stick_choose_by_input(INPUT.special);
	//Special Attacks (ground or aerial)
	if (input_pressed(INPUT.special, buffer_time_standard, false))
		{
		if (_stick == Rstick)
			{
			//Change direction
			var _frame = stick_find_frame(Rstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
			if (_frame == -1) then _frame = 0;
			//Uspec
			if (stick_flicked(Rstick, DIR.up, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
				{
				_started = attack_start(my_attacks[$ "Uspec"], true, Rstick, _frame);
				}
			else
			//Dspec
			if (stick_flicked(Rstick, DIR.down, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
				{
				_started = attack_start(my_attacks[$ "Dspec"], true, Rstick, _frame);
				}
			else
			//Fspec
			if (stick_flicked(Rstick, DIR.horizontal, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
				{
				_started = attack_start(my_attacks[$ "Fspec"], true, Rstick, _frame);
				}
			else
			//Nspec
				{
				//Final Smash
				if (final_smash_uses > 0)
					{
					final_smash_uses--;
					_started = attack_start(my_attacks[$ "Final"]);
					}
				if (!_started)
					{
					_started = attack_start(my_attacks[$ "Nspec"]);
					}
				}
			}
		else
			{
			//Uspec
			if (stick_tilted(Lstick, DIR.up))
				{
				_started = attack_start(my_attacks[$ "Uspec"], true, Lstick);
				}
			else
			//Dspec
			if (stick_tilted(Lstick, DIR.down))
				{
				_started = attack_start(my_attacks[$ "Dspec"], true, Lstick);
				}
			else
			//Fspec
			if (stick_tilted(Lstick, DIR.horizontal))
				{
				_started = attack_start(my_attacks[$ "Fspec"], true, Lstick);
				}
			else
			//Nspec
				{
				//Final Smash
				if (final_smash_uses > 0)
					{
					final_smash_uses--;
					_started = attack_start(my_attacks[$ "Final"]);
					}
				if (!_started)
					{
					_started = attack_start(my_attacks[$ "Nspec"]);
					}
				}
			}
		return _started;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */