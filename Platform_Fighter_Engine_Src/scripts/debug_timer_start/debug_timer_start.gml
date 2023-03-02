///@category Debugging
/*
Starts a debug timer. You can end the timer and see how much time passed using <debug_timer_end> or <debug_timer_end_function>.
Warning: The number of starts and ends must ALWAYS be equal, otherwise timers could return incorrect values or the game could crash.
*/
function debug_timer_start() {
	ds_stack_push(Debug_Timerstack(), get_timer());
}

function Debug_Timerstack() {
	static _stack = ds_stack_create();
	return _stack;
}
/* Copyright 2023 Springroll Games / Yosi */