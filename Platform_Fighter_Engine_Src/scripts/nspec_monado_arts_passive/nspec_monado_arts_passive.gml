function nspec_monado_arts_passive() {
	//assert(!character_static_properties, "[nspec_monado_arts_passive] The macro character_static_properties must be false");
	
	//Variables
	var _s = custom_passive_struct;
	var _num_of_arts = 5;
	if (!variable_struct_exists(_s, "art_selected")) then _s.art_selected = -1;
	if (!variable_struct_exists(_s, "art_lifetime")) then _s.art_lifetime = -1;
	if (!variable_struct_exists(_s, "art_cooldowns")) then _s.art_cooldowns = array_create(_num_of_arts, 0);
	
	//Default properties
	weight_multiplier = 1.0;
	jump_speed = 11.5;
	double_jump_speed = 10.5;
	max_fall_speed = 10;
	fastfall_speed = 14;
	grav = 0.5;
	walk_speed = 3.25;
	dash_speed = 8;
	run_speed = 7;
	damage_attack_multiplier = 1.0;
	damage_taken_multiplier = 1.0;
	knockback_multiplier = 1.0;
	waveland_friction = 0.24;
	
	//Apply art effects
	if (_s.art_selected != -1 && _s.art_lifetime > 0)
		{
		//VFX
		var _vfx_color = c_white;
		
		switch(_s.art_selected)
			{
			//Smash
			case 0:
				weight_multiplier = 1.25;
				damage_attack_multiplier = 0.5;
				knockback_multiplier = 1.5;
				_vfx_color = $5555FF;
				break;
			//Jump
			case 1:
				weight_multiplier = 1.2;
				jump_speed = 15;
				double_jump_speed = 14;
				max_fall_speed = 12;
				fastfall_speed = 16;
				grav = 0.6;
				_vfx_color = $55FF55;
				break;
			//Shield
			case 2:
				weight_multiplier = 0.5;
				jump_speed = 9.5;
				double_jump_speed = 8.5;
				walk_speed = 3;
				dash_speed = 6;
				run_speed = 5;
				damage_attack_multiplier = 0.5;
				damage_taken_multiplier = 0.5;
				knockback_multiplier = 0.5;
				waveland_friction = 1.0;
				_vfx_color = $55FFFF;
				break;
			//Speed
			case 3:
				jump_speed = 9.5;
				double_jump_speed = 8.5;
				walk_speed = 6;
				dash_speed = 10;
				run_speed = 10;
				_vfx_color = $FFFF55;
				break;
			//Buster
			case 4:
				weight_multiplier = 0.75;
				damage_attack_multiplier = 1.5;
				damage_taken_multiplier = 1.5;
				knockback_multiplier = 0.5;
				_vfx_color = $FF5555;
				break;
			default: crash("[nspec_monado_arts_passive] Invalid art selected (", _s.art_selected, ")");
			}
		
		//VFX
		if (_s.art_lifetime % 12 == 0)
			{
			var _vfx = vfx_create(spr_glow_final_smash, 1, 0, 26, x, y, 2, 0, "VFX_Layer_Below");
			_vfx.vfx_xscale = prng_choose(0, -2, 2);
			_vfx.vfx_blend = _vfx_color;
			_vfx.important = true;
			_vfx.follow = id;
			var _w = sprite_get_width(sprite_index);
			var _h = sprite_get_height(sprite_index) div 2;
			_vfx.follow_offset_x = prng_number(3, _w, -_w);
			_vfx.follow_offset_y = prng_number(4, _h, -_h);
			}
		
		//Art lifetime
		_s.art_lifetime = (_s.art_lifetime - 1);
		if (_s.art_lifetime <= 0)
			{
			//10 second cooldown
			_s.art_cooldowns[@ _s.art_selected] = 600;
			_s.art_selected = -1;
			}
		}
		
	//Cooldowns
	for(var i = 0; i < _num_of_arts; i++)
		{
		_s.art_cooldowns[@ i] = max(0, _s.art_cooldowns[@ i] - 1);
		}
		
	//Reset on KO
	if (is_knocked_out())
		{
		_s.art_selected = -1;
		_s.art_lifetime = -1;
		_s.art_cooldowns = array_create(_num_of_arts, 0);
		}
}
/* Copyright 2022 Springroll Games / Yosi
/* Copyright 2023 Springroll Games / Yosi */