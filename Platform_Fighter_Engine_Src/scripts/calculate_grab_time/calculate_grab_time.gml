///@category Attacking
///@param {int} target_damage		The damage of the target being grabbed
/*
Returns how many frames a target would be grabbed based on the given damage.
Players with more damage are held for longer.
*/
function calculate_grab_time() {
	var _d = argument[0];
	return ceil(grab_time_min + (_d * grab_time_multiplier));
}
/* Copyright 2023 Springroll Games / Yosi */