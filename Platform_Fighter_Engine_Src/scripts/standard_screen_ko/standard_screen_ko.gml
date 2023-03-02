///@category Player Standard States
/*
This script contains the default Screen KO state characters are given.

The Screen KO state is for players who are in the screen KO animation, which can randomly happen when launched past the top blastzone.
Players are set to the foreground renderer when in this state.
*/
function standard_screen_ko() {
	//Contains the standard actions for the Screen KO state
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "ScreenKO"]);
			//Timer
			state_frame = screen_ko_time;
			//Renderer
			player_renderer_set(obj_player_renderer_foreground);
			//Held item
			item_visible = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//No values while dead
			speed_set(0, 0, false, false);
			hurtbox_inv_set(hurtbox, INV.invincible, 1, false);

			//Hit the screen
			var _percent = 1 - (state_frame / screen_ko_time);
			if (_percent < 0.3)
				{
				y = 0;
				x = round(room_width div 2);
				}
			else if (_percent < 0.4)
				{
				y = round(lerp(0, room_height div 2, ((_percent - 0.3) / 0.1)));
				anim_scale = ((_percent - 0.3) / 0.1) * screen_ko_scale_multiplier;
				}
			else if (_percent < 0.6)
				{
				}
			else if (_percent < 1.0)
				{
				y = round(lerp(room_height div 2, room_height + (sprite_get_height(anim_sprite) * anim_scale), ((_percent - 0.6) / 0.4)));
				}
				
			//Screenshake / Effects
			if (state_frame == floor(screen_ko_time * 0.6))
				{
				camera_shake(camera_death_shake);
				game_sound_play(snd_hit_strong3);
				game_sound_play(snd_ko_screen);
				}

			//Knock Out
			if (run && state_frame == 0)
				{
				state_set(PLAYER_STATE.knocked_out);
				
				//Effects
				game_sound_play(snd_hit_explosion);
				camera_shake(camera_death_shake);
	
				//VFX
				var _col = palette_color_get(palette_data, 0);
				var _vfx = vfx_create(spr_hit_ko_explosion, 1, 0, 48, x, y, 2, point_direction(x, y, room_width / 2, room_height / 2));
				_vfx.vfx_blend = _col;
				var _vfx = vfx_create(spr_hit_ko_explosion, 1, 0, 48, x, y, 1.5, point_direction(x, y, room_width / 2, room_height / 2));
				_vfx.vfx_yscale *= -1;
				_vfx.vfx_blend = _col;
	
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