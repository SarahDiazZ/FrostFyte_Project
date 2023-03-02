///@category Attacking
/*
Stops the player's current attack and destroys their hitboxes, but does not change their state (unless they have been parried).
*/
function attack_stop_preserve_state() {
	var run = true;

	//Reset attacking variables
	attack_phase = 0;
	attack_frame = 0;
	attack_script = -1;
	simple_attack_name = "";
	can_hitfall = false;

	/*Do not reset landing lag!*/

	//Reset hitboxes
	hitbox_destroy_attached_all();
	hitbox_group_reset_all();
	any_hitbox_has_hit = false;
	any_hitbox_has_been_blocked = false;

	//Parry Stun
	if (run && check_parried()) then run = false;
	parry_stun_time = parry_press_stun_time_default;
}
/* Copyright 2023 Springroll Games / Yosi */