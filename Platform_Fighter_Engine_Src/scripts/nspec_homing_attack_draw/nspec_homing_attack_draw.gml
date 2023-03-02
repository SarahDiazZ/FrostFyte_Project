function nspec_homing_attack_draw() {
	//Neutral Special - Draw
	if (attack_phase == 0)
		{
		//Draw search radius
		var _c = palette_color_get(palette_data, 0);
		if (attack_frame >= 15)
			{
			var _frame = 8 * (1 - ((attack_frame - 15) / 15));
			draw_sprite_ext(spr_nspec_homing_attack_range, _frame, x, y, 2, 2, 0, _c, 0.5);
			}
		
		//Find nearest opponent
		var _nearest = find_nearest_player(x, y, 270, player_team);
		if (_nearest != noone)
			{
			var _scale = 1 + (2 * (attack_frame / 30));
			draw_sprite_ext(spr_nspec_homing_attack, 15, _nearest.x, _nearest.y, _scale, _scale, 0, c_white, 1);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */