///Final Smash for character0 - Draw
function final_smash0_draw() {
	var _accent = palette_color_get(palette_data, 0);
	var _width = 0;
	var _blastzones = obj_stage_manager.blastzones;
	if (attack_phase == 0)
		{
		_width = clamp((1 - ((attack_frame - 10) / 8)) * 96, 0, 96);
		}
	else if (attack_phase == 1)
		{
		_width = clamp((attack_frame / 15) * 96, 0, 96);
		}
		
	draw_set_alpha(0.5);
	var _mult = (facing == 1 ? -0.25 : 0.25);
	draw_line_width_color
		(
		_blastzones.left,
		_mult * (_blastzones.left - custom_attack_struct.final_smash_x) + custom_attack_struct.final_smash_y,
		_blastzones.right,
		_mult * (_blastzones.right - custom_attack_struct.final_smash_x) + custom_attack_struct.final_smash_y,
		_width,
		_accent,
		_accent,
		);
	draw_set_alpha(1);
	
	if (attack_phase == 1)
		{
		fade_shader_set();
		draw_speed_lines
			(
			obj_game.cam_x + (obj_game.cam_w / 2), 
			obj_game.cam_y + (obj_game.cam_h / 2), 
			(14 * facing), 
			c_ltgray, 
			1, 
			-(attack_frame * facing),
			);
		shader_reset();
		}
	else if (attack_phase == 2)
		{
		fade_shader_set();
		draw_speed_lines
			(
			obj_game.cam_x + (obj_game.cam_w / 2), 
			obj_game.cam_y + (obj_game.cam_h / 2), 
			(14 * facing), 
			c_ltgray, 
			(attack_frame / 10), 
			-(attack_frame * facing),
			);
		shader_reset();
		}
}
/* Copyright 2023 Springroll Games / Yosi */