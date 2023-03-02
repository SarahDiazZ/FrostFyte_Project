function nspec_charge_shot_draw() {
	//Neutral Special - Draw
	//Charging up
	if (attack_phase == 1 || attack_phase == 2)
		{
		var _total_charge = 125;
		var _size = lerp(0.45, 1.55, (custom_attack_struct.nspec_charge_shot_charge / _total_charge));
		if (ex_move_is_activated()) then _size = 1;
		palette_shader_set(palette_base, palette_swap, 0.0, 1.0, fade_value, false);
		draw_sprite_ext
			(
			spr_nspec_charge_shot_projectile, 
			obj_game.current_frame div 3, 
			x + (45 * facing), 
			y, 
			_size, 
			_size, 
			0, 
			c_white, 
			1
			);
		shader_reset();
		}
}
/* Copyright 2023 Springroll Games / Yosi */