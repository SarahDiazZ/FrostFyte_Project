///@category Attacking
///@param {int} base_damage			The attack's base damage
///@param {real} [charge]			How much the attack has been charged
///@param {real} [max]				The maximum amount the attack can be charged
///@param {real} [multiplier]		The percent the damage will increase when at full charge
/*
Calculates how much damage a smash attack would do based on how long it has been charged for.
*/
function calculate_smash_damage() {
	var _dmg =		argument[0],
		_charge =	argument_count > 1 ? argument[1] : charge,
		_max =		argument_count > 2 ? argument[2] : smash_attack_charge_max,
		_mult =		argument_count > 3 ? argument[3] : smash_attack_multiplier;
	return (_dmg * (1 + (_charge / _max) * _mult));
}
/* Copyright 2023 Springroll Games / Yosi */