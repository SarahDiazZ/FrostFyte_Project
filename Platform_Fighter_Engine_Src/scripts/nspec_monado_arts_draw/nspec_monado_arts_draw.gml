function nspec_monado_arts_draw() {
	//Arts Wheel
	var _radius = 64;
	var _dir = 90;
	var _num_of_arts = 5;
	var _alpha = 1;
	var _percent = 1;
	var _angle_inc = (360 / _num_of_arts);
	var _s = custom_passive_struct;
	
	//Selected art
	var _selected = -1;
	if (stick_tilted(Lstick))
		{
		_selected = modulo(stick_get_direction(Lstick) - (_angle_inc / 2), 360) div _angle_inc;
		}
	
	//Startup and ending animations
	if (attack_phase == 0)
		{
		_percent = (6 - attack_frame) / 6;
		}
	else if (attack_phase == 2)
		{
		_percent = attack_frame / 10;
		}
	if (_percent != 1)
		{
		_radius = lerp(16, 64, _percent);
		_alpha = lerp(0, 1, _percent);
		}
	
	//Draw the wheel
	for(var i = 0; i < _num_of_arts; i++)
		{
		//Arts on cooldown are grayed out
		var _index = (_s.art_cooldowns[@ i] > 0) ? _num_of_arts : i;
		
		if (i == _selected)
			{
			draw_sprite_ext(spr_nspec_monado_arts_symbols, _index, x + lengthdir_x(_radius, _dir), y + lengthdir_y(_radius, _dir), 1.7, 1.7, 0, c_white, _alpha);
			}
		else
			{
			draw_sprite_ext(spr_nspec_monado_arts_symbols, _index, x + lengthdir_x(_radius, _dir), y + lengthdir_y(_radius, _dir), 1, 1, 0, c_white, _alpha * 0.75);
			}
		_dir += _angle_inc;
		}
}
/* Copyright 2023 Springroll Games / Yosi */