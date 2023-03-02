///@category Attacking
/*
Allows a player to start aerial attacks, and returns true if they do.
*/
function allow_aerial_attacks() {
	var _started = false;
	//If one stick is set to attack it overrides the direction of the other stick
	var _stick = stick_choose_by_input(INPUT.attack);
	//If the attack button was pressed
	if (input_pressed(INPUT.attack, buffer_time_standard, false))
		{
		//If the player is in the air
		if (!on_ground())
			{
			if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
				item_system_type == ITEM_SYSTEM_TYPE.simplified)
				{
				//Pick up items and continue attacking
				pick_up_item();
				}
			
			if (_stick == Rstick)
				{
				if (stick_flicked(Rstick, DIR.up, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
					{
					_started = attack_start(my_attacks[$ "Uair"]);
					}
				else
				if (stick_flicked(Rstick, DIR.down, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
					{
					_started = attack_start(my_attacks[$ "Dair"]);
					}
				else
					{
					var _frame = stick_find_frame(Rstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
					if (_frame == -1) then _frame = 0;
					if (stick_flicked(Rstick, DIR.horizontal, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
						{
						//Is the control stick in the direction the player is facing?
						if (sign(stick_get_value(Rstick, DIR.horizontal, _frame)) == sign(facing))
							{
							_started = attack_start(my_attacks[$ "Fair"]);
							}
						else
							{
							_started = attack_start(my_attacks[$ "Bair"]);
							}
						}
					else
						{
						_started = attack_start(my_attacks[$ "Nair"]);
						}
					}
				}
			else
				{
				if (stick_tilted(Lstick, DIR.up))
					{
					_started = attack_start(my_attacks[$ "Uair"]);
					}
				else
				if (stick_tilted(Lstick, DIR.down))
					{
					_started = attack_start(my_attacks[$ "Dair"]);
					}
				else
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					//Is the control stick in the direction the player is facing?
					if (sign(stick_get_value(Lstick, DIR.horizontal)) == sign(facing))
						{
						_started = attack_start(my_attacks[$ "Fair"]);
						}
					else
						{
						_started = attack_start(my_attacks[$ "Bair"]);
						}
					}
				else
					{
					_started = attack_start(my_attacks[$ "Nair"]);
					}
				}
			return _started;
			}
		}
	//Tether Aerial
	else if (input_pressed(INPUT.grab, buffer_time_standard, false))
		{
		if (!on_ground())
			{
			if (item_system_type == ITEM_SYSTEM_TYPE.simplified)
				{
				//Try to pick up items. Stop the attack and clear the buffer if successful
				if (pick_up_item() != noone)
					{
					input_reset(INPUT.grab);
					return false;
					}
				}
				
			_started = attack_start(my_attacks[$ "Zair"]);
			return _started;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */