///@category Player Actions
/*
This function is called when the player is released from being grabbed.
Run by <grab_release>.
*/
function grab_release_held() {
	state_set(PLAYER_STATE.hitstun);
	speed_set(-facing * grab_release_hsp, grab_release_vsp, false, false);
	knockback_spd = point_distance(0, 0, -facing * grab_release_hsp, grab_release_vsp);
	knockback_dir = point_direction(0, 0, -facing * grab_release_hsp, grab_release_vsp);
	is_reeling = false;
	state_frame = grab_release_hitstun;
	grab_hold_id = noone;
	apply_damage(id, grab_release_damage);
	if (is_knocked_out()) then return;
}
/* Copyright 2023 Springroll Games / Yosi */