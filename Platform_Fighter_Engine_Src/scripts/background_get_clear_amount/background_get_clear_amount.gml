///@category Backgrounds
/*
Returns a number that represents how cleared the background is from 0 (fully cleared) to 1 (normal).
The background is "cleared" when the <background_clear_activate> function is called.
*/
function background_get_clear_amount() {
	return (instance_exists(obj_stage_manager))
		? (1 - obj_stage_manager.background_clear_amount)
		: 0.0;
}
/* Copyright 2023 Springroll Games / Yosi */