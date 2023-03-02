///@category Attacking
///@param {int/real} damage			The attack's damage
///@param {real} angle				The attack's angle
///@param {real} multiplier			A number to multiply the shield pushback amount by
/*
Calulates how much a player would be pushed horizontally when shielding an attack with the given properies.
*/
function calculate_shield_pushback() {
	return (lengthdir_x(argument[0], argument[1]) * shield_pushback_multiplier * argument[2]);
}
/* Copyright 2023 Springroll Games / Yosi */