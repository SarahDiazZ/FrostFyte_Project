///@category Attacking
/*
Allows the player to cancel an attack with a dash while grounded, and returns true if they do.
*/
function cancel_dash_check() {
	if (on_ground())
		{
		if (check_dash())
			{
			attack_stop_preserve_state();
			//Don't allow jumping out of the dash state!
			dash_prevent_jump = true;
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */