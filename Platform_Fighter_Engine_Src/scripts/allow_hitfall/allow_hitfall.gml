///@category Player Actions
///@param {bool} [allow]		Whether to allow hitfalling or not
/*
Calling this function allows the player to hitfall the current attack.
A "hitfall" is fastfalling during the hitlag of an attack.
By default, attacks do NOT allow hitfalling.
*/
function allow_hitfall() {
	if (argument_count > 0)
		{
		can_hitfall = argument[0];
		}
	else
		{
		can_hitfall = true;
		}
}
/* Copyright 2023 Springroll Games / Yosi */