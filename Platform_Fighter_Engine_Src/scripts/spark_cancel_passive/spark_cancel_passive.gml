function spark_cancel_passive() {
	//Make sure the variables are initialized
	if (!variable_struct_exists(custom_passive_struct, "sparks"))
		custom_passive_struct.sparks = 0;
		
	//Gaining a spark on hit
	if (self_hitlag_frame == 1 && state == PLAYER_STATE.attacking && attack_connected())
		{
		custom_passive_struct.sparks = 1;
		}
		
	if (custom_passive_struct.sparks > 0 && state == PLAYER_STATE.attacking)
		{
		var _temp = airdodges;
		airdodges = 1;
		//Super jump cancel
		if (on_ground() &&
			input_pressed(INPUT.jump, buffer_time_standard, false) &&
			input_pressed(INPUT.shield, buffer_time_standard, false))
			{
			input_reset(INPUT.jump);
			input_reset(INPUT.shield);
			
			attack_stop(PLAYER_STATE.tumble);
			if (stick_tilted(Lstick, DIR.horizontal))
				{
				var _dir =  sign(stick_get_value(Lstick, DIR.horizontal, 0));
				speed_set(13 * _dir, -10, false, false);
				}
			else
				{
				speed_set(0, -16, false, false);
				}
			custom_passive_struct.sparks -= 1;
			}
		//Rush cancel
		else if (cancel_airdodge_check())
			{
			custom_passive_struct.sparks -= 1;
			}
		//Jump cancel
		else if (check_jump())
			{
			attack_stop_preserve_state();
			custom_passive_struct.sparks -= 1;
			}
		airdodges = _temp;
		}
		
	//Allow airdodges to be canceled with attacks
	if (state == PLAYER_STATE.airdodging)
		{
		//Attacking
		var run = true;
		if (run && allow_smash_attacks()) then run = false;
		if (run && allow_aerial_attacks()) then run = false;
		if (run && allow_special_attacks()) then run = false;
		}
}

/* Copyright 2023 Springroll Games / Yosi */