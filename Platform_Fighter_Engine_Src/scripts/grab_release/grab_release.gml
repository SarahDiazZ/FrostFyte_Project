///@category Player Actions
/*
Release the player being grabbed by the calling player, dealing small damage and knockback.
This function runs <grab_release_held> on the player that is released.
*/
function grab_release() {
	if (grabbed_id.state == PLAYER_STATE.is_grabbed)
		{
		with(grabbed_id)
			{
			grab_release_held();
			}
		}
	//Grabber goes into a lag state
	state_set(PLAYER_STATE.in_grab_release);
	state_frame = grab_release_hitstun;
	grabbed_id = noone;
	apply_damage(id, grab_release_damage);
	if (is_knocked_out()) then return;
}
/* Copyright 2023 Springroll Games / Yosi */