//Sets all of the variables for a character
function character_init3() {
	if (!object_is(object_index, obj_player))
		{
		crash("Trying to run a character init script on an instance that is not an obj_player!\n",
			"This may be caused by putting parentheses after a script name in Character Data.\n");
		}
		
	//Determine which variables to set
	var _set_properties = argument_count > 0 ? argument[0] : true;
	var _set_states = argument_count > 1 ? argument[1] : true;
	var _set_attacks = argument_count > 2 ? argument[2] : true;
	var _set_sprites = argument_count > 3 ? argument[3] : true;
	
	//Properties
	if (_set_properties)
		{
		//Collision box
		collision_box = spr_collision_mask_large;
	
		//Hurtbox
		hurtbox_sprite = spr_hurtbox3;
		hurtbox_crouch_sprite = spr_hurtbox_crouch3;
	
		//Weight
		weight_multiplier = 0.8;
	
		//Gravity
		grav = 0.7;
		hitstun_grav = 0.6;
	
		//Falling
		max_fall_speed = 10;
		fastfall_speed = 17;
	
		//Jumping
		jumpsquat_time = 4;
		jump_speed = 14;
		jump_horizontal_accel = 5;
		shorthop_speed = 9;
		double_jump_speed = 13;
		double_jump_horizontal_accel = 4;
		max_double_jumps = 1;
		land_time = 5;
	
		//Aerial Movment
		air_accel = 0.25;
		max_air_speed = 5.75;
		max_air_speed_dash = 6.5;
		air_friction = 0.03;
	
		//Ground Movement
		ground_friction = 1.0;
		crouch_friction = 1.5;
		slide_friction = 0.4;
		hard_landing_friction = 0.7;
		jostle_strength = 1.4;
	
		//Walking
		walk_speed = 2.5;
		walk_accel = 0.5;
		walk_turn_time = 6;
	
		//Dashing
		dash_speed = 9;
		dash_time = 9;
		dash_accel = 3;
	
		//Running
		run_speed = 8;
		run_accel = 0.8;
		run_turn_time = 5;
		run_turn_accel = 1;
		run_stop_time = 10;
	
		//Ledges
		ledge_jump_vsp = 15;
		ledge_jump_hsp = 3;
		ledge_jump_time = ledge_jump_time_default;
		ledge_getup_time = ledge_getup_time_default;
		ledge_getup_finish_x = 66;
		ledge_getup_finish_y = -64;
		ledge_roll_time = ledge_roll_time_default;
		ledge_attack_time = ledge_attack_time_default;
		//Some characters would not appear to grab the ledge
		//at the right spot due to sprite origin, so these
		//variables allow you to add an offset.
		ledge_hang_relative_x = -36;
		ledge_hang_relative_y = 38;
	
		//Airdodge Values
		if (airdodge_type == AIRDODGE_TYPE.momentum_stop)
			{
			airdodge_speed = 11;
			airdodge_startup = 2;
			airdodge_active = 10;
			airdodge_endlag = 16;
			waveland_speed_boost = 0;
			waveland_time = 8;
			waveland_friction = 0.24;
			}
		else if (airdodge_type == AIRDODGE_TYPE.momentum_keep)
			{
			airdodge_startup = 1;
			airdodge_active = 18;
			airdodge_endlag = 10;
			airdodge_land_time = 12;
			}
		else if (airdodge_type == AIRDODGE_TYPE.accelerate)
			{
			airdodge_startup = 3;
			airdodge_active = 27;
			airdodge_endlag = 17;
			airdodge_land_time = 10;
			airdodge_dir_windup_speed = 9;
			airdodge_dir_speed_min = 9;
			airdodge_dir_speed_max = 10;
			airdodge_dir_active = 18;
			airdodge_dir_endlag_min = 20;
			airdodge_dir_endlag_max = 45;
			airdodge_dir_grav = 0.2;
			}
		
		//Shield Values
		if (shield_type == SHIELD_TYPE.perfect_shield_start)
			{
			shield_max_hp = 55;
			shield_depeletion_rate = 0.14;
			shield_recover_rate = 0.12;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = 1.4;
			shield_shift_amount = 15;
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
			shield_recover_rate = 0.14;
			shield_break_launch = 13;
			shield_break_reset_hp = 25;
			shield_size_multiplier = 1.4;
			shield_shift_amount = 15;
			shield_release_time = 11;
			parry_ult_window = 5;
			parry_ult_freeze_time = 18;
			parry_ult_self_freeze_time = 10;
			parry_ult_sprite = spr_shield_release0;
			spot_dodge_startup = 3;
			spot_dodge_active = 14;
			spot_dodge_endlag = 14;
			}
		
		//Wall jump Values
		if (wall_jump_type == WALL_JUMP_TYPE.jump_press)
			{
			wall_jump_startup = 4;
			wall_jump_time = 10;
			wall_jump_hsp = 7;
			wall_jump_vsp = -14;
			max_wall_jumps = 1;
			can_wall_cling = false;
			}
		else if (wall_jump_type == WALL_JUMP_TYPE.stick_flick)
			{
			can_wall_jump = true;
			wall_jump_startup = 5;
			wall_jump_time = 8;
			wall_jump_hsp = 7;
			wall_jump_vsp = -10;
			max_wall_jumps = 1;
			can_wall_cling = false;
			}
		
		//Rolling
		roll_speed = 11;
		roll_startup = roll_startup_default;
		roll_active = roll_active_default;
		roll_endlag = roll_endlag_default;
		
		//Getup
		getup_active = getup_active_default;
		getup_endlag = getup_endlag_default;
	
		//Teching
		tech_active = tech_active_default;
		tech_endlag = tech_endlag_default;
		techroll_speed = 12;
		techroll_startup = techroll_startup_default;
		techroll_active = techroll_active_default;
		techroll_endlag = techroll_endlag_default;
	
		//Helpless
		helpless_accel = 0.4;
		helpless_max_speed = 3;
		
		//Items
		item_hold_x_default = 4;
		item_hold_y_default = -20;
		
		//Custom Scripts
		draw_script = -1;
		callback_add(callback_passive, passive3, CALLBACK_TYPE.permanent);
		}

	//States
	if (_set_states)
		{
		player_states_init();
		
		//You can set custom states for a character here, for example:
		//my_states[@ PLAYER_STATE.idle] = <some custom idle script>;
		}

	//Attacks
	if (_set_attacks)
		{
		my_attacks[$ "Jab"		] = jab3;
		my_attacks[$ "DashAtk"	] = dash_attack3;
		my_attacks[$ "Ftilt"	] = ftilt3;
		my_attacks[$ "Utilt"	] = utilt3;
		my_attacks[$ "Dtilt"	] = dtilt3;
				 
		my_attacks[$ "Fsmash"	] = fsmash3;
		my_attacks[$ "Usmash"	] = usmash3;
		my_attacks[$ "Dsmash"	] = dsmash3;
				 
		my_attacks[$ "Nair"		] = nair3;
		my_attacks[$ "Fair"		] = fair_bowser;
		my_attacks[$ "Bair"		] = bair3;
		my_attacks[$ "Uair"		] = uair3;
		my_attacks[$ "Dair"		] = dair3;
				 
		my_attacks[$ "Nspec"	] = nspec3;
		my_attacks[$ "Fspec"	] = fspec3;
		my_attacks[$ "Uspec"	] = uspec3;
		my_attacks[$ "Dspec"	] = dspec3;
				 
		my_attacks[$ "Grab"		] = grab3;
		my_attacks[$ "DashGrab"	] = grab3;
		my_attacks[$ "Pummel"	] = pummel3;
		my_attacks[$ "Zair"		] = -1;
				 
		my_attacks[$ "FThrow"	] = fthrow3;
		my_attacks[$ "BThrow"	] = bthrow3;
		my_attacks[$ "UThrow"	] = uthrow3;
		my_attacks[$ "DThrow"	] = dthrow3;
				 
		my_attacks[$ "GetupAtk"	] = getup_attack3;
		my_attacks[$ "LedgeAtk"	] = ledge_attack3;
		my_attacks[$ "ItemThrow"] = item_throw3;
		my_attacks[$ "ItemAtk"	] = item_attack3;
		my_attacks[$ "Taunt"	] = taunt3;
		my_attacks[$ "Final"	] = final_smash3;
		}

	//Animations / Sprites
	if (_set_sprites)
		{
		sprite_scale = 2;
	
		my_sprites[$ "Entrance"	] = anim_define_ext(spr_idle3, 0, 0.18);
		my_sprites[$ "Idle"		] = anim_define_ext(spr_idle3, 0, 0.18);
		my_sprites[$ "Crouch"	] = spr_crouch3;
		my_sprites[$ "Walk"		] = anim_define_ext(spr_run3, 0, 0.18);
		my_sprites[$ "Walk_Turn"] = anim_define_ext(spr_run3, 0, 0.18);
		my_sprites[$ "Dash"		] = spr_run3;
		my_sprites[$ "Run"		] = spr_run3;
		my_sprites[$ "Run_Turn" ] = spr_run3;
		my_sprites[$ "Run_Stop"	] = anim_define_ext(spr_run3, 0, 0.18);
				 
		my_sprites[$ "JumpSquat"] = spr_crouch3;
		my_sprites[$ "JumpRise"	] = spr_jump_rise3;
		my_sprites[$ "JumpMid"	] = spr_jump_fall3;
		my_sprites[$ "JumpFall"	] = spr_jump_fall3;
		my_sprites[$ "Fastfall"	] = spr_fastfall3;
		my_sprites[$ "DJumpRise"] = spr_jump_rise3;
		my_sprites[$ "DJumpMid"	] = spr_jump_fall3;
		my_sprites[$ "DJumpFall"] = spr_jump_fall3;
		my_sprites[$ "DFastfall"] = spr_fastfall3;
				 
		my_sprites[$ "Airdodge"	] = spr_airdodge3;
		my_sprites[$ "Waveland"	] = spr_crouch3;
		my_sprites[$ "Rolling"	] = spr_rolling3;
		my_sprites[$ "Shield"	] = anim_define(spr_shield_start3, anim_define(spr_idle3));
		my_sprites[$ "ShieldR"	] = spr_idle3;
		my_sprites[$ "ShieldB"	] = anim_define_ext(spr_shield_break3, 0, 0.12);
		my_sprites[$ "ParryS"	] = spr_crouch3;
		my_sprites[$ "SDodge"	] = anim_define_ext(spr_spot_dodge3, 0, anim_calculate_speed(spr_spot_dodge3, 32));
				 
		my_sprites[$ "Hitlag"	] = spr_hitlag3;
		my_sprites[$ "Hitstun"	] = spr_hitstun3;
		my_sprites[$ "Tumble"	] = spr_helpless3;
		my_sprites[$ "Helpless"	] = spr_helpless3;
		my_sprites[$ "Magnet"	] = spr_hitlag3;
		my_sprites[$ "Flinch"	] = spr_crouch3;
		my_sprites[$ "Lag"		] = spr_crouch3;
		my_sprites[$ "Balloon"	] = spr_hitstun3;
		my_sprites[$ "Reeling"	] = spr_reeling3;
		my_sprites[$ "Knockdown"] = anim_define_ext(spr_knockdown3, 4, 0.6, 1, 0, 1, 0, 0, false, anim_define_ext(spr_knockdown3, 7, 0));
		my_sprites[$ "Lock"		] = anim_define_ext(spr_knockdown3, 0, 0.5, 1, 0, 1, 0, 0, false, anim_define_ext(spr_knockdown3, 7, 0));
		my_sprites[$ "Getup"	] = anim_define_ext(spr_getup3, 0, anim_calculate_speed(spr_getup3, getup_active + getup_endlag));
	
		my_sprites[$ "Techroll"	] = spr_rolling3;
		my_sprites[$ "Teching"	] = spr_idle3;
		my_sprites[$ "TechingW"	] = spr_idle3;
		my_sprites[$ "TechingC"	] = spr_idle3;
		my_sprites[$ "Techjump"	] = spr_jump_rise3;
				 
		my_sprites[$ "LedgeS"	] = spr_ledge_snap3;
		my_sprites[$ "Ledge"	] = anim_define_ext(spr_ledge_hang3, 0, 0.1);
		my_sprites[$ "LedgeG"	] = spr_ledge_getup3;
		my_sprites[$ "LedgeJ"	] = spr_ledge_jump3;
		my_sprites[$ "LedgeR"	] = spr_ledge_jump3;
		my_sprites[$ "LedgeA"	] = spr_ledge_jump3;
		my_sprites[$ "LedgeT"	] = -1;
		my_sprites[$ "LedgeTr"	] = -1;
		my_sprites[$ "WallC"	] = -1;
		my_sprites[$ "WallJ"	] = spr_jump_rise3;
	
		my_sprites[$ "StarKO"	] = spr_helpless3;
		my_sprites[$ "ScreenKO"	] = spr_helpless3;
				 
		my_sprites[$ "Grabbing"	] = spr_grabbing3;
		my_sprites[$ "IsGrabbed"] = spr_hitstun3;
		my_sprites[$ "GrabRel"	] = spr_crouch3;
		}
}
/* Copyright 2023 Springroll Games / Yosi */