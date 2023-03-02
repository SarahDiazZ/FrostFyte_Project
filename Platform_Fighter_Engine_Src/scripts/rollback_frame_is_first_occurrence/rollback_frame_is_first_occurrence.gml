///@category Gameplay
/*
Returns true if the current frame is running for the first time by checking <ggmr_session_frame_is_first_occurrence>.
In local matches, this function always returns true.
*/
function rollback_frame_is_first_occurrence() {
	if (game_is_online())
		{
		return true;
		}
	else return true;
}
/* Copyright 2023 Springroll Games / Yosi */