//Sets all of the variables for a character
function character_init5() {
	if (!object_is(object_index, obj_player))
		{
		crash("Trying to run a character init script on an instance that is not an obj_player!\n",
			"This may be caused by putting parentheses after a script name in Character Data.\n");
		}
		
	var _set_properties = argument_count > 0 ? argument[0] : true;
	var _set_states = argument_count > 1 ? argument[1] : true;
	var _set_attacks = argument_count > 2 ? argument[2] : true;
	var _set_sprites = argument_count > 3 ? argument[3] : true;
	
	//Properties
	if (_set_properties)
		{
		//Collision box
		collision_box = spr_collision_mask_medium;
	
		//Hurtbox
		hurtbox_sprite = spr_hurtbox5;
		hurtbox_crouch_sprite = spr_hurtbox_crouch5;
	
		//Weight
		weight_multiplier = 1;
	
		//Gravity
		grav = 0.6;
		hitstun_grav = 0.7;
	
		//Falling
		max_fall_speed = 11;
		fastfall_speed = 16;
	
		//Jumping
		jumpsquat_time = 3;
		jump_speed = 11.5;
		jump_horizontal_accel = 3;
		shorthop_speed = 6.5;
		double_jump_speed = 10.5;
		double_jump_horizontal_accel = 2;
		max_double_jumps = 1;
		land_time = 4;
	
		//Aerial Movment
		air_accel = 0.35;
		max_air_speed = 5.25;
		max_air_speed_dash = 6.75;
		air_friction = 0.04;
	
		//Ground Movement
		ground_friction = 0.75;
		crouch_friction = 1;
		slide_friction = 0.35;
		hard_landing_friction = 0.6;
		jostle_strength = jostle_strength_default;
	
		//Walking
		walk_speed = 3.25;
		walk_accel = 0.5;
		walk_turn_time = 6;
	
		//Dashing
		dash_speed = 8;
		dash_time = 9;
		dash_accel = 8;
	
		//Running
		run_speed = 7;
		run_accel = 0.8;
		run_turn_time = 5;
		run_turn_accel = 1;
		run_stop_time = 4;
	
		//Ledges
		ledge_jump_vsp = 12;
		ledge_jump_hsp = 2;
		ledge_jump_time = ledge_jump_time_default;
		ledge_getup_time = ledge_getup_time_default;
		ledge_getup_finish_x = 40;
		ledge_getup_finish_y = -46;
		ledge_roll_time = ledge_roll_time_default;
		ledge_attack_time = ledge_attack_time_default;
		//Some characters would not appear to grab the ledge
		//at the right spot due to sprite origin, so these
		//variables allow you to add an offset.
		ledge_hang_relative_x = -18;
		ledge_hang_relative_y = 22;
		
		//Shield Values
		if (shield_type == SHIELD_TYPE.perfect_shield_start)
			{
			shield_max_hp = 55;
			shield_depeletion_rate = 0.14;
			shield_recover_rate = 0.14;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = shield_size_multiplier_default;
			shield_shift_amount = 10;
			shield_release_time = 4;
			spot_dodge_startup = 3;
			spot_dodge_active = 14;
			spot_dodge_endlag = 15;
			}
		else if (shield_type == SHIELD_TYPE.parry_press)
			{
			parry_press_startup = 2;
			parry_press_active = 8;
			parry_press_endlag = 30;
			parry_press_trigger_time = 15;
			parry_press_script = parry_press0;
			}
		else if (shield_type == SHIELD_TYPE.parry_shield)
			{
			shield_max_hp = 55;
			shield_depeletion_rate = 0.14;
			shield_recover_rate = 0.12;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = shield_size_multiplier_default;
			shield_shift_amount = 10;
			shield_release_time = 11;
			parry_ult_window = 5;
			parry_ult_freeze_time = 18;
			parry_ult_self_freeze_time = 10;
			parry_ult_sprite = spr_shield_release0;
			spot_dodge_startup = 3;
			spot_dodge_active = 14;
			spot_dodge_endlag = 14;
			}
	
		//Rolling
		roll_speed = 9;
		roll_startup = roll_startup_default;
		roll_active = roll_active_default;
		roll_endlag = roll_endlag_default;
		
		//Getup
		getup_active = getup_active_default;
		getup_endlag = getup_endlag_default;
	
		//Teching
		tech_active = tech_active_default;
		tech_endlag = tech_endlag_default;
		techroll_speed = 10;
		techroll_startup = techroll_startup_default;
		techroll_active = techroll_active_default;
		techroll_endlag = techroll_endlag_default;
	
		//Helpless
		helpless_accel = 0.5;
		helpless_max_speed = 3;
		
		//Items
		item_hold_x_default = 16;
		item_hold_y_default = -4;
		
		//Custom Scripts
		draw_script = -1;
		callback_add(callback_passive, fspec_afterburner_kick_passive, CALLBACK_TYPE.permanent);
		}

	//States
	if (_set_states)
		{
		player_states_init();
		}

	//Attacks
	if (_set_attacks)
		{
		my_attacks[$ "Jab"		] = ntilt5;
		my_attacks[$ "DashAtk"	] = -1;
		my_attacks[$ "Ftilt"	] = stilt5;
		my_attacks[$ "Utilt"	] = utilt5;
		my_attacks[$ "Dtilt"	] = dtilt5;
				 
		my_attacks[$ "Fsmash"	] = fsmash5;
		my_attacks[$ "Usmash"	] = usmash5;
		my_attacks[$ "Dsmash"	] = dsmash5;
				 
		my_attacks[$ "Nair"		] = nair5;
		my_attacks[$ "Fair"		] = fair5;
		my_attacks[$ "Bair"		] = bair5;
		my_attacks[$ "Uair"		] = uair5;
		my_attacks[$ "Dair"		] = dair5;
				 
		my_attacks[$ "Nspec"	] = -1;
		my_attacks[$ "Fspec"	] = -1;
		my_attacks[$ "Uspec"	] = -1;
		my_attacks[$ "Dspec"	] = -1;
		
		my_attacks[$ "Grab"		] = -1;
		my_attacks[$ "DashGrab"	] = -1;
		my_attacks[$ "Pummel"	] = -1;
		my_attacks[$ "Zair"		] = -1;
				 
		my_attacks[$ "FThrow"	] = -1;
		my_attacks[$ "BThrow"	] = -1;
		my_attacks[$ "UThrow"	] = -1;
		my_attacks[$ "DThrow"	] = -1;
		
		my_attacks[$ "GetupAtk"	] = -1;
		my_attacks[$ "LedgeAtk"	] = -1;
		my_attacks[$ "ItemThrow"] = -1;
		my_attacks[$ "ItemAtk"	] = -1;
		my_attacks[$ "Taunt"	] = -1;
		my_attacks[$ "Final"	] = -1;
		}
		
	//Animations / Sprites
	if (_set_sprites)
		{
		sprite_scale = 2;
	
		my_sprites[$ "Entrance"	] = anim_define(spr_entrance5, anim_define(spr_idle5));
		my_sprites[$ "Idle"		] = spr_idle5;
		my_sprites[$ "Crouch"	] = spr_crouch5;
		my_sprites[$ "Walk"		] = spr_walk5;
		my_sprites[$ "Walk_Turn"] = spr_turnaround5;
		my_sprites[$ "Dash"		] = spr_run5;
		my_sprites[$ "Run"		] = spr_run5;
		my_sprites[$ "Run_Turn" ] = spr_turnaround5;
		my_sprites[$ "Run_Stop"	] = spr_walk5;
				 
		my_sprites[$ "JumpSquat"] = spr_jumpsquat5;
		my_sprites[$ "JumpRise"	] = spr_jumprise5;
		my_sprites[$ "JumpMid"	] = spr_jumpmid5;
		my_sprites[$ "JumpFall"	] = spr_jumpfall5;
		my_sprites[$ "Fastfall"	] = spr_fastfall5;
		my_sprites[$ "DJumpRise"] = anim_define(spr_jumprise5, anim_define(spr_jumpfall5));
		my_sprites[$ "DJumpMid"	] = -1;
		my_sprites[$ "DJumpFall"] = -1;
		my_sprites[$ "DFastfall"] = -1;
				 
		my_sprites[$ "Airdodge"	] = spr_airdodge5;
		my_sprites[$ "Waveland"	] = spr_waveland5;
		my_sprites[$ "Rolling"	] = -1;
		my_sprites[$ "Shield"	] = anim_define(spr_shield5, anim_define(spr_shield5));
		my_sprites[$ "ShieldR"	] = -1;
		my_sprites[$ "ShieldB"	] = anim_define_ext(-1, 0, 0.12, 1, 0, 1, 0, 0, true, -1);
		my_sprites[$ "ParryS"	] = -1;
		my_sprites[$ "SDodge"	] = -1;
				 
		my_sprites[$ "Hitlag"	] = spr_crouch5;
		my_sprites[$ "Hitstun"	] = spr_crouch5;
		my_sprites[$ "Tumble"	] = spr_crouch5;
		my_sprites[$ "Helpless"	] = -1;
		my_sprites[$ "Magnet"	] = -1;
		my_sprites[$ "Flinch"	] = -1;
		my_sprites[$ "Lag"		] = spr_waveland5;
		my_sprites[$ "Balloon"	] = -1;
		my_sprites[$ "Reeling"	] = spr_crouch5;
		my_sprites[$ "Knockdown"] = anim_define_ext(spr_crouch5, 2, 0.7, 1, 0, 1, 0, 0, false, anim_define_ext(spr_crouch5, 6, 0));
		my_sprites[$ "Lock"		] = anim_define_ext(-1, 0, 0.5, 1, 0, 1, 0, 0, false, anim_define_ext(-1, 6, 0));
		my_sprites[$ "Getup"	] = anim_define_ext(-1, 0, anim_calculate_speed(-1, getup_active + getup_endlag));
	
		my_sprites[$ "Techroll"	] = -1; 
		my_sprites[$ "Teching"	] = -1;
		my_sprites[$ "TechingW"	] = -1;
		my_sprites[$ "TechingC"	] = -1;
		my_sprites[$ "Techjump"	] = -1;
				 
		my_sprites[$ "LedgeS"	] = -1;
		my_sprites[$ "Ledge"	] = -1;
		my_sprites[$ "LedgeG"	] = -1;
		my_sprites[$ "LedgeJ"	] = -1;
		my_sprites[$ "LedgeR"	] = -1;
		my_sprites[$ "LedgeA"	] = -1;
		my_sprites[$ "LedgeT"	] = anim_define_ext(-1, 0, 0.3, 1, 0, 1, 0, 16, true, -1);
		my_sprites[$ "LedgeTr"	] = -1;
		my_sprites[$ "WallC"	] = -1;
		my_sprites[$ "WallJ"	] = -1;
	
		my_sprites[$ "StarKO"	] = -1;
		my_sprites[$ "ScreenKO"	] = -1;
				 
		my_sprites[$ "Grabbing"	] = -1;
		my_sprites[$ "IsGrabbed"] = -1;
		my_sprites[$ "GrabRel"	] = -1;
		}
}
