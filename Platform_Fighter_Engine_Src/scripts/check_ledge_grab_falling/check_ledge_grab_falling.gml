///@category Player Actions
/*
Allows the player to grab a nearby ledge if they are currently falling, and returns true if they do.
See <check_ledge_grab> for the list of conditions that must be met to grab the ledge.
*/
function check_ledge_grab_falling() {
	if (vsp >= 0)
		{
		return check_ledge_grab();
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */