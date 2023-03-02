///@category Player Actions
/*
Allows the player to footstool an opponent, and returns true if they do.
If <footstools_enable> is false, this function will do nothing and return false.
*/
function check_footstool() {
	//Make sure footstooling is enabled.
	if (!footstools_enable || footstool_cooldown > 0) then return false;

	//If the jump button is pressed
	if (input_pressed(INPUT.jump, buffer_time_standard, false))
		{
		//Footstool the first opponent under you
		var _opponent = noone;
		var _lowest_synced_id = infinity;
		with(obj_player)
			{
			//Cannot footstool yourself
			if (id == other.id) then continue;
			
			//Cannot footstool invincible players
			if (hurtbox.inv_type == INV.invincible) then continue;
			
			//Can only footstool players in specific states:
			if (state == PLAYER_STATE.aerial ||
				state == PLAYER_STATE.crouching ||
				state == PLAYER_STATE.dashing ||
				state == PLAYER_STATE.helpless ||
				state == PLAYER_STATE.hitlag ||
				state == PLAYER_STATE.hitstun ||
				state == PLAYER_STATE.idle ||
				state == PLAYER_STATE.in_grab_release ||
				state == PLAYER_STATE.in_lag ||
				state == PLAYER_STATE.jumpsquat ||
				state == PLAYER_STATE.magnetized ||
				state == PLAYER_STATE.parry_stun ||
				state == PLAYER_STATE.run_stop ||
				state == PLAYER_STATE.run_turnaround ||
				state == PLAYER_STATE.running ||
				state == PLAYER_STATE.shield_break ||
				state == PLAYER_STATE.shield_release ||
				state == PLAYER_STATE.tumble ||
				state == PLAYER_STATE.walk_turnaround ||
				state == PLAYER_STATE.walking ||
				state == PLAYER_STATE.wall_jump ||
				state == PLAYER_STATE.wavelanding)
				{
				//Check that the other player is above you and colliding
				if (bbox_top > other.bbox_top && place_meeting(x, bbox_top, other.id))
					{
					if (sync_id < _lowest_synced_id)
						{
						_lowest_synced_id = sync_id;
						_opponent = id;
						}
					}
				}
			}
			
		if (_opponent != noone)
			{
			//Jump off the opponent
			footstool_cooldown = 20;
			move_x(_opponent.x - x, true);
			move_y(true, _opponent.bbox_top - y, true);
			input_reset(INPUT.jump);
			state_set(PLAYER_STATE.aerial);
			double_jump();
			double_jumps++;
			speed_set(0, 0, false, true);
			
			with(_opponent)
				{
				if (!on_ground())
					{
					//Opponent falls down with special properties
					asdi_multiplier = 0;
					di_angle = 0;
					launch_player(270, -2, 45, PLAYER_STATE.hitstun);
					is_reeling = true;
					can_tech = false;
					}
				else
					{
					//Opponent is stunned in place
					state_set(PLAYER_STATE.flinch);
					speed_set(0, 0, false, false);
					state_frame = 30;
					}
				}
			
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */