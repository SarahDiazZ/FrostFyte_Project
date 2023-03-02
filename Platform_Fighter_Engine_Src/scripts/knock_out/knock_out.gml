///@category Player Actions
/*
Knocks out the calling player.
This will destroy their active hitboxes, shake the camera, play a sound effect, and reduce their remaining stocks / points.
If the player is outside the top of the room, there is a change they will be Star KO'ed or Screen KO'ed.
*/
function knock_out() {
	//Players cannot be knocked out on unconfirmed frames when online
	if (!rollback_frame_is_confirmed()) then return;

	//Stop the attack, if you are currently attacking
	attack_stop();
	hitbox_destroy_attached_all();
	
	//Destroy the held item
	if (item_held != noone)
		{
		with(item_held)
			{
			instance_destroy();
			}
		item_held = noone;
		item_visible = true;
		}
		
	//Break out of grabs
	grab_hold_id = noone;
	grabbed_id = noone;

	//Star KO / Screen KO
	var _ko = true;
	//You can only get a Star / Screen KO if you have more than 1 stock left and there are at least 10 seconds on the clock
	var _time_left = (setting().match_time * 60 * 60) - obj_game.game_time;
	if ((!match_has_stock_set() || stock > 1) &&
		(!match_has_time_set() || _time_left > (10 * 60)))
		{
		if (y < 0)
			{
			if (obj_game.current_frame % star_ko_chance == 0)
				{
				state_set(PLAYER_STATE.star_ko);
				_ko = false;
				}
			else if (obj_game.current_frame % screen_ko_chance == 0)
				{
				state_set(PLAYER_STATE.screen_ko);
				_ko = false;
				}
			}
		}

	//Default KO
	if (_ko)
		{
		state_set(PLAYER_STATE.knocked_out);
	
		//Effects
		game_sound_play(snd_blastzone);
		camera_shake(camera_death_shake);
		
		//Explosion VFX - depends on if you're outside of the blastzones or not
		if (!match_has_stamina_set() && blastzones_check())
			{
			var _col = palette_color_get(palette_data, 0);
			var _vfx = vfx_create(spr_hit_ko_explosion, 1, 0, 48, x, y, 2, point_direction(x, y, room_width / 2, room_height / 2));
			_vfx.vfx_blend = _col;
			var _vfx = vfx_create(spr_hit_ko_explosion, 1, 0, 48, x, y, 1.5, point_direction(x, y, room_width / 2, room_height / 2));
			_vfx.vfx_yscale *= -1;
			_vfx.vfx_blend = _col;
			}
		else
			{
			var _col = palette_color_get(palette_data, 0);
			var _vfx = vfx_create(spr_hit_final_hit, 1, 0, 36, x, y, 2, prng_number(0, 360));
			_vfx.vfx_blend = _col;
			}
	
		//Stock matches
		if (match_has_stock_set())
			{
			stock--;
			}

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
		}

	//Invulnerability
	invulnerability_set(INV.invincible, state_frame);
	
	//Add to the replay data
	if (rollback_frame_is_first_occurrence())
		{
		var _data = 
			{
			frame : obj_game.current_frame,
			character : character,
			color : player_color,
			number : player_number,
			};
		array_push(engine().replay_player_ko_frames, _data);
		}
}
/* Copyright 2023 Springroll Games / Yosi */