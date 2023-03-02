///@category Player Standard States
/*
This script contains the default Knocked Out state characters are given.

The Knocked Out state is for players who have been knocked out and are waiting to respawn.
*/
function standard_knocked_out() {
	//Contains the standard actions for the knocked out state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_reset();
			anim_sprite = -1;
			//Timer
			state_frame = ko_time_min;
			//Distance scaling
			if (ko_property != noone)
				{
				var _center_x = mean(obj_stage_manager.blastzones.right, obj_stage_manager.blastzones.left);
				state_frame = ceil(min(ko_time_min + (abs(ko_property.x - _center_x) * ko_distance_scaling), ko_time_max));
				}
			//1v1 Scoreboard
			if (hud_1v1_scoreboard_enable && array_length(engine().player_data) == 2)
				{
				if (match_has_stock_set() || match_has_time_set())
					{
					obj_game.hud_1v1_scoreboard_frame = state_frame;
					obj_game.hud_1v1_scoreboard_total_frames = state_frame;
					}
				}
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Invulnerability
			hurtbox_inv_set(hurtbox, INV.invincible, 1, false);

			//Respawn
			if (run && state_frame == 0)
				{
				respawn();
				run = false;
				}
			//No movement
			speed_set(0, 0, false, false);
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */