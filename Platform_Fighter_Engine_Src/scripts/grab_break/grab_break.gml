///@category Player Actions
/*
Breaks the grab that the calling player is in, pushing both players backwards.
This must be called from the player that is being grabbed.
*/
function grab_break() {
	//Both players are pushed back
	state_set(PLAYER_STATE.hitstun);
	speed_set(-facing * grab_break_speed, 0, false, false);
	knockback_spd = point_distance(0, 0, -facing * grab_break_speed, 0);
	knockback_dir = point_direction(0, 0, -facing * grab_break_speed, 0);
	is_reeling = false;
	state_frame = grab_break_lag;
	self_hitlag_frame = grab_break_hitlag;
	
	with(grab_hold_id)
		{
		if (grabbed_id == other.id)
			{
			state_set(PLAYER_STATE.hitstun);
			knockback_spd = point_distance(0, 0, -facing * grab_break_speed, 0);
			knockback_dir = point_direction(0, 0, -facing * grab_break_speed, 0);
			is_reeling = false;
			speed_set(-facing * grab_break_speed, 0, false, false);
			state_frame = grab_break_lag;
			self_hitlag_frame = grab_break_hitlag;
			grabbed_id = noone;
			}
		}
		
	//VFX
	if (grab_hold_id != noone && !is_knocked_out(grab_hold_id) && !is_knocked_out())
		{
		var _vfx = vfx_create(spr_hit_grab_break, 1, 0, 16, mean(x, grab_hold_id.x), mean(y, grab_hold_id.y), 1, prng_number(0, 360));
		_vfx.vfx_xscale = prng_choose(1, -1, 1);
		_vfx.vfx_yscale = prng_choose(2, -1, 1);
		_vfx.important = true;
		}
		
	//Reset variables
	grab_hold_id = noone;
}
/* Copyright 2023 Springroll Games / Yosi */