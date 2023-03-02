///The passive script for character1
function passive1() {
	var _on_ground = on_ground();
	var _is_knocked_out = is_knocked_out();
	
	//Floaty jump variables
	var _float_time = 19;
	var _float_max_speed = -12;
	var _float_accel = -1.7;
	var _float_dip = 3;
	var _float_dip_time = 2;
	if (!variable_struct_exists(custom_passive_struct, "float_frame"))
		{
		custom_passive_struct.float_frame = _float_time;
		}
	
	//Reset the float frame when you start a double jump
	if (state == PLAYER_STATE.aerial && jump_is_midair_jump && state_time == 0)
		{
		custom_passive_struct.float_frame = 0;
		speed_set(0, _float_dip, true, false);
		}
	else if (state == PLAYER_STATE.aerial || (state == PLAYER_STATE.attacking && !_on_ground))
		{
		if (custom_passive_struct.float_frame > _float_dip_time &&
			custom_passive_struct.float_frame < _float_time &&
			vsp > _float_max_speed)
			{
			speed_set(0, _float_accel, true, true);
			}
		custom_passive_struct.float_frame++;
		}
	else
		{
		custom_passive_struct.float_frame = _float_time;
		}
	
	//Side Special
	if (_on_ground || _is_knocked_out)
		{
		attack_uses_set(1, fspec1);
		}
		
	//Charge variable
	if (!variable_struct_exists(custom_attack_struct, "dspec1_charge"))
		{
		custom_attack_struct.dspec1_charge = 0;
		}
		
	//Charge animation
	if (custom_attack_struct.dspec1_charge >= 180 && obj_game.current_frame % 60 == 0)
		{
		flash_alpha = 0.7;
		flash_color = c_white;
		}
		
	//Lose Down Special charge when KO'ed
	if (_is_knocked_out)
		{
		custom_passive_struct.float_frame = 0;
		custom_attack_struct.nspec_charge_shot_charge = 0;
		custom_attack_struct.dspec1_charge = 0;
		}
		
	//Fully Charged Down B Cancel on hit
	if (state == PLAYER_STATE.attacking && attack_connected())
		{
		if (custom_attack_struct.dspec1_charge >= 180)
			{
			var _stick = stick_choose_by_input(INPUT.special);
			if (input_pressed(INPUT.special, buffer_time_standard, false))
				{
				if (_stick == Rstick && stick_flicked(Rstick, DIR.down, buffer_time_standard, true, STICK_CHECK_TYPE.backwards))
					{
					//Change direction
					var _frame = stick_find_frame(Rstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
					if (_frame == -1) then _frame = 0;
					attack_start(my_attacks[$ "Dspec"], true, Rstick, _frame);
					}
				else if (stick_tilted(Lstick, DIR.down))
					{
					attack_start(my_attacks[$ "Dspec"], true, Lstick);
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */