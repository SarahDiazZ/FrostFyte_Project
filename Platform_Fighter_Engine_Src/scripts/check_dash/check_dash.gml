///@category Player Actions
/*
Allows the player to dash, and returns true if they do.
*/
function check_dash() {
	//If the control stick was previously flicked horizontally
	var _frame = stick_find_frame(Lstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
	if (_frame != -1)
		{
		//Change the facing direction
		change_facing(Lstick, _frame);
		//Set the state to dashing and stop the script.
		state_set(PLAYER_STATE.dashing);
		//VFX
		var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
		_vfx.vfx_xscale = 2 * facing;
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */