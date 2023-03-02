///@category Attacking
///@param {real} base_hitlag			The base hitlag of the move
///@param {int/real} target_damage		The damage of the player being hit
///@param {real} scaling				The hitlag scaling of the move
/*
Calculates how much hitlag a move would apply.
"Hitlag" is the number of frames a player is frozen when hit by an attack.
Players with more damage will have more hitlag.
*/
function calculate_hitlag() {
	var _lag = argument[0];
	var _dmg = argument[1];
	var _sca = argument[2];
	return ceil(min((_dmg * _sca * hitlag_damage_multiplier) + (_lag * hitlag_multiplier), hitlag_time_max));
}
/* Copyright 2023 Springroll Games / Yosi */