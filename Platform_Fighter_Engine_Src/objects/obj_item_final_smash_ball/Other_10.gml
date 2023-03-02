//VFX
obj_stage_manager.background_fog_color = c_black;
obj_stage_manager.background_fog_alpha = max(0.4, obj_stage_manager.background_fog_alpha);

if (obj_game.current_frame % 8 == 0)
	{
	var _vfx = vfx_create(spr_glow_final_smash, 1, 0, 26, x, y, 2, 0, "VFX_Layer_Below");
	_vfx.vfx_xscale = prng_choose(0, -2, 2);
	_vfx.vfx_blend = make_color_hsv(prng_number(1, 255), prng_number(2, 200, 50), 255);
	_vfx.follow = id;
	var _w = sprite_get_width(sprite_index);
	var _h = sprite_get_height(sprite_index) div 2;
	_vfx.follow_offset_x = prng_number(3, _w, -_w);
	_vfx.follow_offset_y = prng_number(4, _h, -_h);
	}

//Hitlag
if (self_hitlag_frame <= 0)
	{
	//Random movement
	var _middle_x = mean(obj_stage_manager.blastzones.left, obj_stage_manager.blastzones.right);
	var _middle_y = mean(obj_stage_manager.blastzones.top, obj_stage_manager.blastzones.bottom);
	hsp = approach(hsp, clamp(_middle_x - x + prng_number(0, 100, -100), -5, 5), 0.3);
	vsp = approach(vsp, clamp(_middle_y - y + prng_number(1, 100, -100), -5, 5), 0.3);
	x += round(hsp);
	y += round(vsp);

	//Inherit the parent event
	event_inherited();
	if (!instance_exists(id)) then exit;
	}
	
self_hitlag_frame = max(0, self_hitlag_frame - 1);
/* Copyright 2023 Springroll Games / Yosi */