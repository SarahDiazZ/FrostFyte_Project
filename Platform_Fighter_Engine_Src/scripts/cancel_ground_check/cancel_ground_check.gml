///@category Attacking
/*
If the player is on the ground, their attack is canceled and the function returns true.
*/
function cancel_ground_check() {
	var _landed = false;
	if (vsp == 0 && landed_on_ground) then _landed = true;
	else if (vsp >= 0 && on_solid()) then _landed = true;
	else if (vsp >= 0 && !stick_tilted(Lstick, DIR.down) && on_ground()) then _landed = true;
	
	if (_landed)
		{
		attack_stop(PLAYER_STATE.in_lag);
		
		//It's possible that the player could go into parry stun, so double check that they are actually in landing lag
		if (state == PLAYER_STATE.in_lag)
			{
			state_frame = landing_lag;
			}
			
		speed_set(0, 0, true, false);
		
		//VFX
		vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
		return true;
		}
	return false;
}

/* Copyright 2023 Springroll Games / Yosi */