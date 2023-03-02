///@category Attacking
///@param {asset} attack			The attack script to start.
/*
Checks if the player is able to start an attack, that is, if the attack is not on cooldown and not out of uses.
*/
function attack_can_start() {
	var _atk = argument[0];
	
	assert(!is_undefined(_atk), "[attack_can_start] The attack script cannot be undefined!\nA common cause of this would be including parentheses after the attack script name during assignment, for example:\nmy_attacks[? \"Jab\"] = jab1();");
	
	if (script_exists(_atk))
		{
		//Check the cooldown
		var _cooldown = attack_cooldowns[$ string(_atk)];
		if (!is_undefined(_cooldown) && _cooldown > 0)
			{
			return false;
			}
			
		//Check the uses
		var _uses = attack_uses[$ string(_atk)];
		if (!is_undefined(_uses) && _uses != -1)
			{
			if (_uses <= 0)
				{
				return false;
				}
			}
		
		return true;
		}
		
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */