function final_smash_startup_script() {
	//The player can't be hit
	invulnerability_set(INV.deactivate, -1);
	hurtbox.sprite_index = -1;
	
	//VFX
	vfx_create(spr_shine_large, 1, 0, 14, x, y, 2, 41);
	camera_shake(2);
	for(var i = 0; i < 12; i++)
		{
		var _dir = (30 * i) + prng_number(i, 10, -10);
		var _len = 48 + (dcos(30 * i * 6) * 4);
		var _vfx = vfx_create(spr_glow_final_smash, 1, 0, 26, x + lengthdir_x(_len, _dir), y + lengthdir_y(_len, _dir), 2, _dir - 90, "VFX_Layer_Below");
		_vfx.vfx_xscale = prng_choose(i + 2, 2, -2);
		_vfx.vfx_blend = make_color_hsv(prng_number(i, 255), prng_number(i + 1, 200, 50), 255);
		}
	
	//Dark fog
	callback_add(callback_passive, final_smash_fog_passive, CALLBACK_TYPE.temporary);
	
	//Freeze frames
	freeze_gameplay(26);
	
	//Sound effect
	game_sound_play(snd_activation);
}
/* Copyright 2023 Springroll Games / Yosi */