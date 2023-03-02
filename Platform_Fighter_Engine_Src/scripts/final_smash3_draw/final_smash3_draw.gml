function final_smash3_draw() {
	var _percent = 0;
	var _cx = obj_game.cam_x + (obj_game.cam_w div 2);
	var _cy = obj_game.cam_y + (obj_game.cam_h div 2);
	var _parallax = 0;
	var _fade = 0;
	
	if (attack_phase == 1 && attack_frame <= 15)
		{
		_fade = (1 - (attack_frame / 15)) * 0.5;
		}
	else if (attack_phase == 2)
		{
		_percent = 1 - (attack_frame / 15);
		_fade = 0.5 + (_percent * 0.5);
		_parallax = _percent * 50;
		}
	else if (attack_phase == 3)
		{
		_fade = 1;
		_percent = 1;
		_parallax = 50 + ((-y + camera_height_start) / 10);
		}
	else if (attack_phase == 4)
		{
		_percent = (attack_frame / 15);
		_fade = 0.5 + (_percent * 0.5);
		_parallax = _percent * 28;
		}
	else if (attack_phase == 5)
		{
		_fade = (1 - ((120 - attack_frame) / 15)) * 0.5;
		}
		
	draw_sprite_ext(spr_final_smash3_gradient, 0, _cx, obj_game.cam_y + (796 * 2 * _fade), 2, 2, 0, c_white, 1);
	draw_sprite_ext(spr_final_smash3_background, 0, _cx, _cy, 2, 2, 0, c_white, _percent);
	draw_sprite_ext(spr_final_smash3_clouds1, 0, _cx, _cy + (_parallax * 0.1), 2, 2, 0, c_white, _percent);
	
	//Draw grabbed player
	if (attack_phase == 3 && attack_frame < 115)
		{
		with(grabbed_id)
			{
			player_draw_self(x, obj_game.cam_y + y);
			}
		player_draw_self(x, obj_game.cam_y + y);
		}
	
	draw_sprite_ext(spr_final_smash3_clouds2, 0, _cx, _cy + (_parallax * 0.3), 2, 2, 0, c_white, _percent);
	draw_sprite_ext(spr_final_smash3_clouds3, 0, _cx, _cy + (_parallax * 0.6), 2, 2, 0, c_white, _percent);
	
	//VFX
	if (attack_phase == 3)
		{
		if (attack_frame <= 70 && attack_frame > 56)
			{
			draw_sprite_ext(spr_shine_large, (70 - attack_frame) div 2, x, obj_game.cam_y + y - 48, 2, 2, attack_frame, c_white, 1);
			}
		}
	if (((attack_phase == 1 && attack_frame <= 41) || (attack_phase > 1 && attack_phase < 6)) && _percent < 1)
		{
		var _time = 0;
		if (attack_phase >= 1 && attack_phase <= 3)
			{
			_time = -state_time;
			}
		else
			{
			_time = state_time;
			}
		fade_shader_set();
		draw_speed_lines(obj_game.cam_x + (obj_game.cam_w / 2), obj_game.cam_y + (obj_game.cam_h / 2), 90, c_ltgray, 1 - _percent, _time);
		shader_reset();
		}
}
/* Copyright 2023 Springroll Games / Yosi */