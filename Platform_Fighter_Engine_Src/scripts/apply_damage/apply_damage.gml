///@category Attacking
///@param {id} player_id			The id of the player to be damaged
///@param {int/real} damage			How much damage to give to the player
/*
Applies a given amount of damage to a player instance.
If <damage_decimal_places> is greater than zero, this number can be any real number; otherwise, it must be an integer.
In a stamina match, if the player's HP drops to 0 as a result of the damage, the player is knocked out.
The player's damage cannot go over the max damage, and cannot go under 0.
If <show_damage_numbers> is turned on, this function will create the text.
*/
function apply_damage() {
	var _id = argument[0];
	var _d = argument[1];
	
	//Round damage
	if (damage_decimal_places == 0)
		{
		_d = ceil(_d);
		}
	
	with(_id)
		{
		//Stamina
		if (match_has_stamina_set())
			{
			stamina = clamp(stamina - _d, 0, damage_max);
			damage = clamp(damage + _d, 0, damage_max);
			
			//Check for KOs
			if (stamina <= 0)
				{
				knock_out();
				}
			}
		//Normal damage
		else
			{
			damage = clamp(damage + _d, 0, damage_max);
			}
			
		//VFX
		if (_d > 0) then damage_text_random = ceil(_d);
		
		//Damage numbers
		if (setting().show_damage_numbers && _d != 0)
			{
			with(instance_create_layer(x + prng_number(0, 14, -14), y + prng_number(0, 14, -14), layer, obj_notice))
				{
				custom_vfx_struct.color = c_white;
				custom_vfx_struct.text = string_format(_d, 0, damage_decimal_places);
				lifetime = 60;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */