///@category Backgrounds
/*
Returns true if the background is currently cleared.
The background is "cleared" when the <background_clear_activate> function is called.
*/
function background_is_cleared() {
	return (instance_exists(obj_stage_manager))
		? (obj_stage_manager.background_clear_frame != 0)
		: false;
}
/* Copyright 2023 Springroll Games / Yosi */