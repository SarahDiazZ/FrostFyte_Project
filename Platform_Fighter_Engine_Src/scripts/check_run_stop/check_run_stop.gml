///@category Player Actions
/*
Allows the player to stop running, and returns true if they do.
*/
function check_run_stop() {
	//The player enters the run stop state when they are no longer tilting the control stick
	if (!stick_tilted(Lstick,DIR.horizontal))
		{
		state_set(PLAYER_STATE.run_stop);
		state_frame = run_stop_time;
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */