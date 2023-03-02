///@category Debugging
/*
Ends the debug timer that was started last, and logs how much time has passed.
Warning: The number of starts and ends must ALWAYS be equal, otherwise timers could return incorrect values or the game could crash.
*/
function debug_timer_end() {
	var _time = (get_timer() - ds_stack_pop(Debug_Timerstack()));
	log("Time: " + string(_time));
}
/* Copyright 2023 Springroll Games / Yosi */