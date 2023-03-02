///@category Player Standard States
/*
This script contains the default Ledge Snap state characters are given.

The Ledge Snap state is for players who are moving towards the ledge to grab it.
Players in this state do not inherently have invulnerability, which allows them to be "2-framed", or hit right as they grab the ledge (the actual number of frames is not exactly 2).
*/
function standard_ledge_snap() {
	//Contains the standard actions for the ledge snap state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "LedgeS"]);
			
			//Allow for "2 frame" punish
			invulnerability_set(INV.normal, 1);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Facing
			facing = ledge_id.image_xscale;
			
			//Move toward the ledge
			if (run)
				{
				speed_set_towards_point
					(
					ledge_id.x + (ledge_hang_relative_x * facing),
					ledge_id.y + (ledge_hang_relative_y),
					ledge_snap_speed
					);
				}

			//Exit the state when the timer is done
			if (state_frame == 0)
				{
				//Snap to the ledge
				x = ledge_id.x + (ledge_hang_relative_x * facing);
				y = ledge_id.y + (ledge_hang_relative_y);
	
				run = false;
				
				//Trump / Hog
				if (ledge_type == LEDGE_TYPE.trump || ledge_type == LEDGE_TYPE.hog)
					{
					state_set(PLAYER_STATE.ledge_hang);
		
					//Ledge Trump
					//All of the other players grabbing the same ledge get trumped if they hung on the ledge for long enough
					if (ledge_type == LEDGE_TYPE.trump)
						{
						with(obj_player)
							{
							if (id == other.id) continue;
							//Check ledge and state
							if (ledge_id == other.ledge_id && state == PLAYER_STATE.ledge_hang && state_time >= ledge_hang_time_min)
								{
								state_set(PLAYER_STATE.ledge_trump);
								hsp = ledge_trump_hsp * facing;
								vsp = ledge_trump_vsp;
								state_frame = ledge_trump_stun_time;
								}
							}
						}
					}
				//Mantling
				else if (ledge_type == LEDGE_TYPE.mantle)
					{
					//Start ledge getup
					state_set(PLAYER_STATE.ledge_getup);
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
				}
		
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */