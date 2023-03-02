///The passive script for adding a final smash meter
function final_smash_meter_passive() {
    var _fs_meter_max = 600;

	//Make sure the variables are initialized
	if (!variable_struct_exists(custom_passive_struct, "fs_meter"))
		{
		custom_passive_struct.fs_meter = 0;
		}

    //Adding to the meter - if you don't have a final smash already
	if (final_smash_uses <= 0)
		{
	    if (state == PLAYER_STATE.attacking && attack_connected() && self_hitlag_frame == 1)
			{
			custom_passive_struct.fs_meter += (combo_counter == 1 ? 65 : 20);
			}
		else if (state == PLAYER_STATE.hitlag && state_time == 1)	
			{
			custom_passive_struct.fs_meter += 15;
			}
		}
	else
		{
		if (state == PLAYER_STATE.attacking && attack_connected() && self_hitlag_frame == 1)
			{
			custom_passive_struct.fs_meter += 20;
			}
		else if (state == PLAYER_STATE.hitlag && state_time == 1)	
			{
			custom_passive_struct.fs_meter -= 20;
			}
		}
		
	//Decrease when grabbing the ledge
	if (state == PLAYER_STATE.ledge_snap && state_time == 0)	
		{
		custom_passive_struct.fs_meter -= 30;
		}
	
	//Give the player a final smash use when the meter is full
	if (custom_passive_struct.fs_meter == _fs_meter_max)
		{
		final_smash_uses = 1;
		}
		
	//Slowly drain the meter if you have a final smash
	if (final_smash_uses > 0)
		{
		custom_passive_struct.fs_meter -= 1;
		}
	if (custom_passive_struct.fs_meter <= 0)
		{
		final_smash_uses = 0;
		}
		
	//Clamp
	custom_passive_struct.fs_meter = clamp(custom_passive_struct.fs_meter, 0, _fs_meter_max);
	
	//Reset meter when you use the final smash
	if (state == PLAYER_STATE.attacking && attack_script == my_attacks[$ "Final"])
		{
		final_smash_uses = 0;
		custom_passive_struct.fs_meter = 0;	
		}
	//Lose meter when KO'd
	/*
	if (is_knocked_out())
		{
		final_smash_uses = 0;
		custom_passive_struct.fs_meter = 0;
		}
	*/
}
/* Copyright 2023 Springroll Games / Yosi */