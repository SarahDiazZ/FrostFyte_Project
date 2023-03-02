///@category Player Actions
/*
If the player is currently standing on a solid block or a platform, this function switches them to the landing lag state and returns true.
*/
function check_landing() {
	var _landed = false;
	if (vsp == 0 && landed_on_ground) then _landed = true;
	else if (vsp >= 0 && on_solid()) then _landed = true;
	else if (vsp >= 0 && !stick_tilted(Lstick, DIR.down) && on_ground()) then _landed = true;
	
	if (_landed)
		{
		//Stop speed and change state
		speed_set(0, 0, true, false);
		state_set(PLAYER_STATE.in_lag);
		state_frame = land_time;
		//VFX
		vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */