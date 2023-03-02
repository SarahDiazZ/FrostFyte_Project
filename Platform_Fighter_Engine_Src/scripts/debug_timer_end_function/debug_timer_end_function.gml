///@category Debugging
/*
Ends the debug timer that was started last, and runs the given function with the amount of time passed as the first argument.
Warning: The number of starts and ends must ALWAYS be equal, otherwise timers could return incorrect values or the game could crash.
*/
function debug_timer_end_function(_func) {
	var _time = (get_timer() - ds_stack_pop(Debug_Timerstack()));
	_func(_time);
}
/* Copyright 2023 Springroll Games / Yosi */