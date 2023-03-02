///@category Player Actions
/*
Allows the player to waveland, and returns true if they do.
Players below a platform can snap upwards onto the platform if the distance is within the <platform_snap_up_threshold>.
Players above a platform can snap downwards onto the platform if the distance is within the <platform_snap_down_threshold>.
Neutral airdodges will not snap either direction.
*/
function check_waveland() {
	//Neutral airdodges cannot waveland
	if (!airdodge_is_directional && !on_ground()) then return false;
	
	//Only waveland if you are NOT moving upwards
	if (vsp >= 0)
		{
		//Snap landing UP onto platforms
		var _plat = collision(x, y, [FLAG.plat]);
		if (_plat != noone)
			{
			var _diff = (bbox_bottom - 1) - _plat.bbox_top;
			if (_diff <= platform_snap_up_threshold)
				{
				if (!collision(x, y - (_diff + 1), [FLAG.solid]))
					{
					y -= _diff + 1;
					//Change state & set timer
					state_set(PLAYER_STATE.wavelanding);
					state_frame = waveland_time;
					//Set the speeds
					speed_set(0, 0, true, false);
					//Do not set hsp because it carries over to wavelanding
					hsp += (waveland_speed_boost * sign(hsp));
					//VFX
					var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * sign(hsp);
					return true;
					}
				}
			}
			
		//Snap landing DOWN onto platforms
		var _plat = collision(x, y + platform_snap_down_threshold, [FLAG.plat]);
		if (_plat != noone && (bbox_bottom - 1) < _plat.bbox_top)
			{
			var _diff = _plat.bbox_top - (bbox_bottom - 1);
			if (_diff <= platform_snap_down_threshold)
				{
				if (!collision(x, y + (_diff - 1), [FLAG.solid]))
					{
					y += _diff - 1;
					//Change state & set timer
					state_set(PLAYER_STATE.wavelanding);
					state_frame = waveland_time;
					//Set the speeds
					speed_set(0, 0, true, false);
					//Do not set hsp because it carries over to wavelanding
					hsp += (waveland_speed_boost * sign(hsp));
					//VFX
					var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * sign(hsp);
					return true;
					}
				}
			}
			
		//Normal landing
		if (on_ground())
			{
			//Change state & set timer
			state_set(PLAYER_STATE.wavelanding);
			state_frame = waveland_time;
			//Set the speeds
			vsp = 0;
			vsp_frac = 0;
			//Do not set hsp because it carries over to wavelanding
			hsp += (waveland_speed_boost * sign(hsp));
			//VFX
			var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
			_vfx.vfx_xscale = 2 * sign(hsp);
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */