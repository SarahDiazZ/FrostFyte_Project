///@category Player Actions
/*
Allows the player to grab a nearby ledge, and returns true if they do.

Ledge grab conditions:
	- The player cannot be on the opposite side of the ledge
	- The bottom of the player must be below the ledge
	- The player must be close enough to the ledge
	- The player cannot be holding down on the control stick
	- The player cannot be holding away from the ledge
				
If "ledge_type" is LEDGE_TYPE.hog:
	- No other players are currently grabbing that ledge
	
If "ledge_type" is LEDGE_TYPE.mantle, then players need to press the jump button to grab ledge
*/
function check_ledge_grab() {
	if (instance_number(obj_ledge) > 0)
		{
		if (ledge_grab_timeout == 0 && (ledge_grab_max == -1 || ledge_grab_counter < ledge_grab_max))
			{
			var _nearest = instance_nearest(x, y, obj_ledge);
	
			/*
			Ledge grab conditions:
				The player cannot be on the opposite side of the ledge
				The bottom of the player must be below the ledge
				The player must be close enough to the ledge
				The player cannot be holding down on the control stick
				The player cannot be holding away from the ledge
				
			If ledge_type is LEDGE_TYPE.hog:
				No other players are currently grabbing that ledge
				
			If "ledge_type" is LEDGE_TYPE.mantle, then players need to press the jump button to grab ledge
			*/
	
			if (sign(_nearest.x - x) != -_nearest.image_xscale && 
				(bbox_bottom - 1) > _nearest.y &&
				distance_to_point(_nearest.x, _nearest.y) < ledge_grab_distance &&
				not stick_tilted(Lstick, DIR.down) &&
				(abs(stick_get_value(Lstick, DIR.horizontal)) < stick_tilt_amount ||
				sign(stick_get_value(Lstick, DIR.horizontal)) != -_nearest.image_xscale))
				{
				//Ledge hogging
				var _can_grab = true;
				if (ledge_type == LEDGE_TYPE.hog)
					{
					with(obj_player)
						{
						if (id != other.id && ledge_id == _nearest &&
							(state == PLAYER_STATE.ledge_snap ||
							state == PLAYER_STATE.ledge_hang ||
							state == PLAYER_STATE.ledge_getup ||
							state == PLAYER_STATE.ledge_attack ||
							state == PLAYER_STATE.ledge_roll ||
							state == PLAYER_STATE.ledge_jump))
							{
							_can_grab = false;
							break;
							}
						}
					}
						
				//Mantling
				if (ledge_type == LEDGE_TYPE.mantle)
					{
					_can_grab = input_pressed(INPUT.jump);
					}
				
				if (_can_grab)
					{
					state_set(PLAYER_STATE.ledge_snap);
					ledge_id = _nearest;
					state_frame = ledge_snap_time;
					facing = _nearest.image_xscale;
					//VFX
					vfx_create(spr_shine_ledge_grab, 1, 0, 10, ledge_id.x, ledge_id.y, 1, prng_number(0, 360));
					return true;
					}
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */