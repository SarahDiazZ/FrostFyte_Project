///@category Attacking
/*
Allows a player to start a pummel, and returns true if they do.
This function does not check if the player is actually grabbing an opponent.
*/
function allow_pummels() {
	//If the attack, grab, or special buttons are pressed
	if (input_pressed(INPUT.attack, buffer_time_standard, false) || 
		input_pressed(INPUT.grab, buffer_time_standard, false) || 
		input_pressed(INPUT.special, buffer_time_standard, false))
		{
		var _started = attack_start(my_attacks[$ "Pummel"]);
		return _started;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */