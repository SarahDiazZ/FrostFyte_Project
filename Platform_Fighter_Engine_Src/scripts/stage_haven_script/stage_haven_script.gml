function stage_haven_script() {
	if (!custom_stage_struct.haven_final_form)
		{
		//If all players have 1 or fewer stocks remaining, or there is 1 minute left
		var _last_stock = false;
		var _last_minute = false;
		if (match_has_stock_set())
			{
			_last_stock = true;
			with(obj_player)
				{
				if (stock > 1)
					{
					_last_stock = false;
					break;
					}
				}
			}
		if (match_has_time_set())
			{
			if (((setting().match_time * 60) - (obj_game.game_time / 60)) <= 60)
				{
				_last_minute = true;
				}
			}
		if (_last_stock || _last_minute)
			{
			custom_stage_struct.haven_final_form = true;
			custom_stage_struct.haven_transform_frame = 0;
				
			//Change the music
			audio_sound_gain(music, 0, 100);
			audio_stop_sound(music);
				
			//Background fade
			background_clear_activate(60, c_ltgray, -1, 0.1);
			}
		}
	//Final Form Effects
	else
		{
		custom_stage_struct.haven_transform_frame += 1;
		var _frame = custom_stage_struct.haven_transform_frame;
		
		//Switch assets during the fade
		if (_frame == 30)
			{
			//Change the background
			background = 
				[
				background_define(back_haven_distant_final, 0, 0, 2, 0, 0),
				background_define_script(back_haven_stars_final, 0, 0, 2, 0, 0, 0, 0, false, 0, stage_haven_shader_draw),
				background_define(back_haven_spikes_final, 0, 0, 2, 0.1, 0.1),
				background_define(back_haven_spikes2_final, 0, 0, 2, 0.3, 0.3),
				background_define(back_haven_spikes3_final, 0, 0, 2, 0.4, 0.4),
				back_clear,
				];
				
			//Change the assets
			with(obj_haven_renderer)
				{
				if (sprite_index == back_haven_stage) then sprite_index = back_haven_stage_final;
				if (sprite_index == back_haven_plat) then sprite_index = back_haven_plat_final;
				if (sprite_index == back_haven_grass) then sprite_index = back_haven_grass_final;
				}
			
			//Change the stage tint
			stage_tint = [0.2, 0.1, 0.2];
			}
		
		//Camera shaking
		if (_frame < 60)
			{
			camera_shake(1);
			background_clear_color = make_color_hsv((_frame / 60) * 255, 100, 255);
			}
		else if (_frame == 60)
			{
			//Music
			audio_stop_sound(music);
			stage_music_set(song_haven_final);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */