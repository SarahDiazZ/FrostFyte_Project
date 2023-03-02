///@category Gameplay
///@param {int} event			The GGMR event that was triggered, from the enum GGMR_EVENT
///@param {any} [extra]			Any extra arguments that might be included for specific events
/*
A callback function used in GGMR for online play.
It handles any GGMR event value.
*/
function game_ggmr_event() {
	crash("[game_ggmr_event] This script should not be called!", debug_get_callstack());
}
/* Copyright 2023 Springroll Games / Yosi */