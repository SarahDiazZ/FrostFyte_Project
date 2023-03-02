///@category Player Actions
/*
Puts both the grabbing player and the grabbed player in the "grab break struggle" attack state.
This must be called from the player that is being grabbed.
*/
function grab_break_struggle_start() {
	//Reset variables
	speed_set(0, 0, false, false);
	
	//Start the attack for both players
	attack_stop(PLAYER_STATE.idle);
	attack_start(grab_break_struggle_attack);
	custom_ids_struct.struggle_opponent = grab_hold_id;
	
	with(grab_hold_id)
		{
		attack_stop(PLAYER_STATE.idle);
		attack_start(grab_break_struggle_attack);
		custom_ids_struct.struggle_opponent = other.id;
		}
	
	//Reset variables
	grab_hold_id = noone;
}
/* Copyright 2023 Springroll Games / Yosi */