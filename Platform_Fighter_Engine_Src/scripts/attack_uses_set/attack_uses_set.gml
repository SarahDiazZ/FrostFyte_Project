///@category Attacking
///@param {int} uses						The number of times the attack can be used
///@param {asset} [attack_script]			The attack to change the number of uses
/*
Changes how many times an attack can be used.
If no attack script is provided, the player's current attack is chosen.
By default, all attacks can be used an infinite number of times. If you set a number of uses for an attack but want to change it back to infinite uses, set the number of uses to -1.
*/
function attack_uses_set() {
	var _uses = argument[0];
	var _script = (argument_count > 1 && script_exists(argument[1])) ? argument[1] : attack_script;

	if (_script != -1)
		{
		attack_uses[$ string(_script)] = _uses;
		}
}
/* Copyright 2023 Springroll Games / Yosi */