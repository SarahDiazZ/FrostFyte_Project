function airdash_passive() {
	//*Grab input
	//Make sure the variables are initialized
	if (!variable_struct_exists(custom_passive_struct, "airdash_number"))
		custom_passive_struct.airdash_number = 1;

	//Airdashing
	if (custom_passive_struct.airdash_number > 0 && (state == PLAYER_STATE.aerial || (state == PLAYER_STATE.attacking && !on_ground())))
		{
		//Grab
		if (input_held(INPUT.grab) && stick_tilted(Lstick, DIR.horizontal))
			{
			var _dir = sign(stick_get_value(Lstick, DIR.horizontal, 0));
			attack_stop(PLAYER_STATE.tumble);
			speed_set(9.5 * _dir, -3, false, false);
				
			//VFX
			var _vfx = vfx_create(spr_hit_normal_weak, 1, 0, 14, x, y, 1, _dir == 1 ? 180 : 0, "VFX_Layer_Below");
			_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				
			custom_passive_struct.airdash_number -= 1;
			}
		}
	//*/

	/*Double flick input
	//Make sure the variables are initialized
	if (!variable_struct_exists(custom_passive_struct, "airdash_number"))
		custom_passive_struct.airdash_number = 1;
	if (!variable_struct_exists(custom_passive_struct, "airdash_flicked_dir"))
		custom_passive_struct.airdash_flicked_dir = undefined;
	if (!variable_struct_exists(custom_passive_struct, "airdash_flicked_time"))
		custom_passive_struct.airdash_flicked_time = 0;

	//Airdashing
	if (custom_passive_struct.airdash_number > 0 && (state == PLAYER_STATE.aerial || (state == PLAYER_STATE.attacking && !on_ground())))
		{
		//Timer
		custom_passive_struct.airdash_flicked_time -= 1;
		if (custom_passive_struct.airdash_flicked_time <= 0)
			{
			custom_passive_struct.airdash_flicked_dir = undefined;
			}
		
		//Flick
		if (stick_flicked(Lstick, DIR.horizontal, 0, false))
			{
			if (custom_passive_struct.airdash_flicked_dir == undefined)
				{
				custom_passive_struct.airdash_flicked_time = 12;
				custom_passive_struct.airdash_flicked_dir = sign(stick_get_value(Lstick, DIR.horizontal));
				}
			else if (custom_passive_struct.airdash_flicked_time > 0 &&
				custom_passive_struct.airdash_flicked_dir == sign(stick_get_value(Lstick, DIR.horizontal)))
				{
				attack_stop(PLAYER_STATE.tumble);
				speed_set(9.5 * custom_passive_struct.airdash_flicked_dir, -3, false, false);
				
				//VFX
				var _vfx = vfx_create(spr_hit_normal_weak, 1, 0, 13, x, y, 1, custom_passive_struct.airdash_flicked_dir == 1 ? 180 : 0, "VFX_Layer_Below");
				_vfx.vfx_yscale *= prng_choose(0, -1, 1);
				
				custom_passive_struct.airdash_flicked_dir = undefined;
				custom_passive_struct.airdash_number -= 1;
				}
			}
		}
	else 
		{
		custom_passive_struct.airdash_flicked_time = 0;
		}
	//*/
		
	//Restore airdashes on the ground
	if (on_ground())
		{
		//custom_passive_struct.airdash_flicked_time = 0;
		custom_passive_struct.airdash_number = 1;
		custom_passive_struct.airdash_flicked_dir = undefined;
		}

	if (is_knocked_out())
		{
		custom_passive_struct.airdash_number = 1;
		custom_passive_struct.airdash_flicked_dir = false;
		}
	return;
}
/* Copyright 2023 Springroll Games / Yosi */