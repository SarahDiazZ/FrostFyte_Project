///@category Player Standard States
/*
This script contains the default Star KO state characters are given.

The Star KO state is for players who are in the star KO animation, which can randomly happen when launched past the top blastzone.
Players are set to the background renderer when in this state.
*/
function standard_star_ko() {
	//Contains the standard actions for the Star KO state
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "StarKO"]);
			//Timer
			state_frame = star_ko_time;
			//Renderer
			player_renderer_set(obj_player_renderer_background);
			//Held item
			item_visible = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//No values while dead
			speed_set(0, 0, false, false);
			hurtbox_inv_set(hurtbox, INV.invincible, 1, false);

			//Fall at the top of the screen
			var _percent = (1 - state_frame / star_ko_time);
			x = round(lerp(x, room_width div 2, 0.01));
			y = round(_percent * star_ko_distance);
			anim_scale = (1 - _percent);

			//Knock Out
			if (run && state_frame == 0)
				{
				//Change state
				state_set(PLAYER_STATE.knocked_out);
	
				//VFX
				vfx_create(spr_shine_fastfall, 1, 0, 12, x, y, 2, 0, "VFX_Layer_Below");
				game_sound_play(snd_ko_star);
	
				//Stock matches
				stock--;

				//Lose if no stocks left
				if (match_has_stock_set() && stock <= 0)
					{
					state_frame = -1;
					stock = 0;
					state_set(PLAYER_STATE.lost);
					}
				else if (!match_has_stock_set() && match_has_time_set())
					{
					with(ko_property)
						{
						points++;
						}
					ko_property = noone;
					points--;
					}
				run = false;
				}

			//No movement
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */