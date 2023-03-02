///@category Attacking
///@param {int} cooldown					The number of frames of cooldown
///@param {asset} [attack_script]			The attack to assign the cooldown to
/*
Assigns a certain number of frames of cooldown to an attack.
If no attack script is provided, the cooldown is given to the player's current attack.
Attack cooldown prevents players from starting a certain attack via attack_start, but will not do anything if the player is already using the attack.
*/
function attack_cooldown_set() {
	var _cool = argument[0];
	var _script = (argument_count > 1 && script_exists(argument[1])) ? argument[1] : attack_script;

	if (_script != -1)
		{
		attack_cooldowns[$ string(_script)] = _cool;
		}
}
/* Copyright 2023 Springroll Games / Yosi */