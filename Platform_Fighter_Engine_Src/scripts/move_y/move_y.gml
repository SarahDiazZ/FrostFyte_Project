///@category Collisions
///@param {bool} [drop_through]		If the player will drop through platforms or not
///@param {int} [vsp]				The vertical speed
///@param {bool} [lock_vsp]			Whether to prevent the vsp from changing or not
/*
Moves the player a certain amount vertically, taking slopes into account. If no speed is given, the player's vsp variable is used.
If the drop_through argument is true, players can move through platforms downward.
If lock_vsp is true, the player's vsp variable will not be affected by this function.
Please note: This function meant to be used in other collision functions and should not be called independently.
*/
function move_y() {
	var _drop = argument_count > 0 ? argument[0] : false;
	var _vsp = argument_count > 1 ? argument[1] : vsp;
	var _lock = argument_count > 2 ? argument[2] : false;
	
	if (_vsp != 0)
		{
		for(vsp_moved = 0; vsp_moved < abs(_vsp); vsp_moved++)
			{
			if (_vsp < 0)
				{
				if (!collision(x, y + sign(_vsp), [FLAG.solid]))
					{
					y += sign(_vsp);
					}		
				else
					{
					if (move_against_slope_y(_vsp))
						{
						//Successfully moved against the slope!
						}
					else
						{
						if (!_lock)
							{
							if (vsp > 0) then landed_on_ground = true;
							vsp_frac = 0;
							vsp = 0;
							}
						break;
						}
					}
				}
			else if (_vsp > 0)
				{
				if (!_drop)
					{
					if (on_ground())
						{
						if (!_lock)
							{
							if (vsp > 0) then landed_on_ground = true;
							vsp_frac = 0;
							vsp = 0;
							}
						break;
						}
					else
						{
						y += sign(_vsp);
						}
					}
				else
					{
					if (!on_solid())
						{
						y += sign(_vsp);
						}
					else
						{
						if (!_lock)
							{
							if (vsp > 0) then landed_on_ground = true;
							vsp_frac = 0;
							vsp = 0;
							}
						break;
						}
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */