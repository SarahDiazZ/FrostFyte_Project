///@category Attacking
/*
Allows the player to cancel an attack with a jump, and returns true if they do.
*/
function cancel_jump_check() {
	if (input_pressed(INPUT.jump, buffer_time_standard, false))
		{
		if (on_ground())
			{
			attack_stop(PLAYER_STATE.jumpsquat);
			input_reset(INPUT.jump);
			state_frame = jumpsquat_time;
			return true;
			}
		else
		if (double_jumps > 0)
			{
			attack_stop(PLAYER_STATE.aerial);
			input_reset(INPUT.jump);
			double_jump();
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */