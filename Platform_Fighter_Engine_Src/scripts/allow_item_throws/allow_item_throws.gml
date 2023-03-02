///@category Attacking
/*
Allows a player to throw their held item, and returns true if they do.
*/
function allow_item_throws() {
	var _started = false;
	
	//The player must be holding an item
	if (item_held == noone || !instance_exists(item_held)) then return false;
	
	//The item must be throwable
	var _type = item_held.custom_entity_struct.item_type;
	if (_type != ITEM_TYPE.throwing &&
		_type != ITEM_TYPE.projectile &&
		_type != ITEM_TYPE.melee) then return false;
	
	//Possible inputs (different depending on the item system in use and the item type)
	var _attack = false;
	var _grab = false;
	var _smash = false;
	var _stick = Lstick;
	
	switch(item_system_type)
		{
		case ITEM_SYSTEM_TYPE.standard:
			//Check all inputs
			_attack = input_pressed(INPUT.attack, buffer_time_standard, false);
			_grab = input_pressed(INPUT.grab, buffer_time_standard, false);
			_smash = input_pressed(INPUT.smash, buffer_time_standard, false);
			
			//Disabled inputs
			if (_type == ITEM_TYPE.melee || _type == ITEM_TYPE.projectile)
				{
				_attack = false;
				_smash = false;
				}
				
			//Right stick
			if (stick_choose_by_input(INPUT.attack) == Rstick ||
				stick_choose_by_input(INPUT.grab) == Rstick ||
				stick_choose_by_input(INPUT.smash) == Rstick)
				{
				_stick = Rstick;
				}
			break;
		case ITEM_SYSTEM_TYPE.simplified:
			_grab = input_pressed(INPUT.grab, buffer_time_standard, false);
			break;
		}
		
	var _drop_item = false;
	
	//If any of the inputs were pressed
	if (_attack || _grab || _smash)
		{
		//Choose the direction
		if (_stick == Rstick)
			{
			if (stick_flicked(Rstick, DIR.up, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
				{
				item_throw_direction = 90;
				}
			else
			if (stick_flicked(Rstick, DIR.down, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
				{
				item_throw_direction = 270;
				}
			else
				{
				var _frame = stick_find_frame(Rstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
				if (_frame == -1) then _frame = 0;
				if (stick_flicked(Rstick, DIR.horizontal, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
					{
					//Turn around the player
					if (sign(stick_get_value(Rstick, DIR.horizontal, _frame)) == 1)
						{
						item_throw_direction = 0;
						facing = 1;
						}
					else
						{
						item_throw_direction = 180;
						facing = -1;
						}
					}
				else 
				if (_grab && !on_ground())
					{
					_drop_item = true;
					}
				else
					{
					//Forward throw
					item_throw_direction = (facing == 1)
						? 0
						: 180;
					}
				}
			}
		else
			{
			if (stick_tilted(Lstick, DIR.up))
				{
				item_throw_direction = 90;
				}
			else
			if (stick_tilted(Lstick, DIR.down))
				{
				item_throw_direction = 270;
				}
			else
			if (stick_tilted(Lstick, DIR.horizontal))
				{
				//Turn around the player
				if (sign(stick_get_value(Lstick, DIR.horizontal)) == 1)
					{
					item_throw_direction = 0;
					facing = 1;
					}
				else
					{
					item_throw_direction = 180;
					facing = -1;
					}
				}
			else 
			if (_grab && !on_ground())
				{
				_drop_item = true;
				}
			else
				{
				//Forward throw
				item_throw_direction = (facing == 1)
					? 0
					: 180;
				}
			}
			
		//Dropping items
		if (_drop_item)
			{
			throw_item(-1);
			
			//Reset the input so you don't immediately regrab the item
			input_reset(INPUT.grab);
			return false;
			}
		
		//Try to start the attack
		_started = attack_start(my_attacks[$ "ItemThrow"]);
		
		//Default throw if the character has no attack script
		if (!_started && my_attacks[$ "ItemThrow"] == -1)
			{
			throw_item();
			
			//Reset inputs so you don't immediately regrab the item
			//Please note: If the player has the right stick set to Attack or Smash,
			//they can drop and regrab the item since the stick cannot be reset.
			//This is why character-specific item throws with more lag are useful.
			if (_attack) then input_reset(INPUT.attack);
			if (_grab) then input_reset(INPUT.grab);
			if (_smash) then input_reset(INPUT.smash);
			
			return true;
			}

		return _started;
		}
		
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */