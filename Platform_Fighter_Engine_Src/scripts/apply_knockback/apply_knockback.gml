///@category Attacking
///@param {real} angle		The angle of the knockback
///@param {real} speed		The speed of the knockback
///@param {int} hitlag		How many frames the calling player is frozen before knockback is applied
/*
Applies knockback to the calling player.
*/
function apply_knockback() {
	//These variables are just temporary holders.
	//After hitlag, hsp and vsp are set using these.
	knockback_dir = argument[0];
	knockback_spd = argument[1];
	
	//Reeling
	is_reeling = false;
	
	//No movement during hitlag
	speed_set(0, 0, false, false);
	
	//Set state and the hitlag timer
	state_set(PLAYER_STATE.hitlag);
	state_frame = argument[2];
}
/* Copyright 2023 Springroll Games / Yosi */