//Sets all of the variables for a character
function character_init4() {
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
		collision_box = spr_collision_mask_medium;
	
		//Hurtbox
		hurtbox_sprite = spr_hurtbox2;
		hurtbox_crouch_sprite = spr_hurtbox_crouch0;
	
		//Weight
		weight_multiplier = 1.1;
	
		//Gravity
		grav = 0.81;
		hitstun_grav = 0.55;
	
		//Falling
		max_fall_speed = 15;
		fastfall_speed = 19;
	
		//Jumping
		jumpsquat_time = 3;
		jump_speed = 18;
		jump_horizontal_accel = 6;
		shorthop_speed = 8.5;
		double_jump_speed = 14;
		double_jump_horizontal_accel = 6;
		max_double_jumps = 1;
		land_time = 4;
	
		//Aerial Movment
		air_accel = 0.55;
		max_air_speed = 5.15;
		max_air_speed_dash = 7.5;
		air_friction = 0.05;
	
		//Ground Movement
		ground_friction = 0.85;
		crouch_friction = 1;
		slide_friction = 0.35;
		hard_landing_friction = 0.5;
		jostle_strength = jostle_strength_default;
	
		//Walking
		walk_speed = 4.5;
		walk_accel = 0.65;
		walk_turn_time = 5;
	
		//Dashing
		dash_speed = 9;
		dash_time = 12;
		dash_accel = 7;
	
		//Running
		run_speed = 7.5;
		run_accel = 1.5;
		run_turn_time = 3;
		run_turn_accel = 2.5;
		run_stop_time = 8;
	
		//Ledges
		ledge_jump_vsp = 17;
		ledge_jump_hsp = 2;
		ledge_jump_time = ledge_jump_time_default;
		ledge_getup_time = ledge_getup_time_default;
		ledge_getup_finish_x = 48;
		ledge_getup_finish_y = -46;
		ledge_roll_time = ledge_roll_time_default;
		ledge_attack_time = ledge_attack_time_default;
		//Some characters would not appear to grab the ledge
		//at the right spot due to sprite origin, so these
		//variables allow you to add an offset.
		ledge_hang_relative_x = -18;
		ledge_hang_relative_y = 22;
	
		//Airdodge Values
		if (airdodge_type == AIRDODGE_TYPE.momentum_stop)
			{
			airdodge_speed = 9;
			airdodge_startup = 2;
			airdodge_active = 10;
			airdodge_endlag = 16;
			waveland_speed_boost = 1;
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
			shield_recover_rate = 0.14;
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
		
		//Wall jump Values
		if (wall_jump_type == WALL_JUMP_TYPE.jump_press)
			{
			wall_jump_startup = 2;
			wall_jump_time = 10;
			wall_jump_hsp = 4;
			wall_jump_vsp = -13;
			max_wall_jumps = 1;
			can_wall_cling = true;
			}
		else if (wall_jump_type == WALL_JUMP_TYPE.stick_flick)
			{
			can_wall_jump = true;
			wall_jump_startup = 2;
			wall_jump_time = 8;
			wall_jump_hsp = 7;
			wall_jump_vsp = -8;
			max_wall_jumps = 1;
			can_wall_cling = true;
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
		helpless_accel = 0.6;
		helpless_max_speed = 3;
		
		//Items
		item_hold_x_default = 18;
		item_hold_y_default = -2;
		
		//Custom Scripts
		draw_script = -1;
		callback_add(callback_passive, passive4, CALLBACK_TYPE.permanent);
		callback_add(callback_hud, hud4, CALLBACK_TYPE.permanent);
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
		my_attacks[$ "Jab"		] = jab4;
		my_attacks[$ "DashAtk"	] = dash_attack4;
		my_attacks[$ "Ftilt"	] = ftilt4;
		my_attacks[$ "Utilt"	] = utilt4;
		my_attacks[$ "Dtilt"	] = dtilt4;
				 
		my_attacks[$ "Fsmash"	] = fsmash4;
		my_attacks[$ "Usmash"	] = usmash4;
		my_attacks[$ "Dsmash"	] = dsmash4;
				 
		my_attacks[$ "Nair"		] = nair4;
		my_attacks[$ "Fair"		] = fair4;
		my_attacks[$ "Bair"		] = bair4;
		my_attacks[$ "Uair"		] = uair4;
		my_attacks[$ "Dair"		] = dair4;
				 
		my_attacks[$ "Nspec"	] = nspec4;
		my_attacks[$ "Fspec"	] = fspec4;
		my_attacks[$ "Uspec"	] = uspec4;
		my_attacks[$ "Dspec"	] = dspec4;
				 
		my_attacks[$ "Grab"		] = grab0;
		my_attacks[$ "DashGrab"	] = dash_grab0;
		my_attacks[$ "Pummel"	] = pummel4;
		my_attacks[$ "Zair"		] = -1;
				 
		my_attacks[$ "FThrow"	] = fthrow4;
		my_attacks[$ "BThrow"	] = bthrow4;
		my_attacks[$ "UThrow"	] = uthrow4;
		my_attacks[$ "DThrow"	] = dthrow4;
				 
		my_attacks[$ "GetupAtk"	] = getup_attack0;
		my_attacks[$ "LedgeAtk"	] = ledge_attack0;
		my_attacks[$ "ItemThrow"] = item_throw0;
		my_attacks[$ "ItemAtk"	] = item_attack0;
		my_attacks[$ "Taunt"	] = taunt4;
		my_attacks[$ "Final"	] = final_smash4;
		}

	//Animations / Sprites
	if (_set_sprites)
		{
		sprite_scale = 2;
	
		my_sprites[$ "Entrance"	] = anim_define(spr_entrance2, anim_define_ext(spr_idle4, 0, 0.18));
		my_sprites[$ "Idle"		] = anim_define_ext(spr_idle4, 0, 0.18);
		my_sprites[$ "Crouch"	] = anim_define(spr_crouch_begin0, anim_define(spr_crouch0));
		my_sprites[$ "Walk"		] = spr_walk0;
		my_sprites[$ "Walk_Turn"] = spr_walk0;
		my_sprites[$ "Dash"		] = spr_run0;
		my_sprites[$ "Run"		] = spr_run0;
		my_sprites[$ "Run_Turn" ] = spr_run0;
		my_sprites[$ "Run_Stop"	] = spr_run_stop0;
			 
		my_sprites[$ "JumpSquat"] = spr_jumpsquat0;
		my_sprites[$ "JumpRise"	] = spr_jump_rise0;
		my_sprites[$ "JumpMid"	] = spr_jump_mid0;
		my_sprites[$ "JumpFall"	] = spr_jump_fall0;
		my_sprites[$ "Fastfall"	] = spr_fastfall0;
		my_sprites[$ "DJumpRise"] = anim_define(spr_djump_rise4, anim_define(spr_jump_fall0));
		my_sprites[$ "DJumpMid"	] = -1;
		my_sprites[$ "DJumpFall"] = -1;
		my_sprites[$ "DFastfall"] = -1;
			 
		my_sprites[$ "Airdodge"	] = spr_airdodge0;
		my_sprites[$ "Waveland"	] = spr_waveland0;
		my_sprites[$ "Rolling"	] = spr_rolling0;
		my_sprites[$ "Shield"	] = anim_define(spr_shield_start0, anim_define(spr_shield0));
		my_sprites[$ "ShieldR"	] = spr_idle0;
		my_sprites[$ "ShieldB"	] = anim_define_ext(spr_shield_break0, 0, 0.12, 1, 0, 1, 0, 0, true, -1);
		my_sprites[$ "ParryS"	] = spr_parry_stun0;
		my_sprites[$ "SDodge"	] = spr_spot_dodge0;
			 
		my_sprites[$ "Hitlag"	] = spr_hitlag0;
		my_sprites[$ "Hitstun"	] = spr_hitstun0;
		my_sprites[$ "Tumble"	] = spr_tumble0;
		my_sprites[$ "Helpless"	] = spr_helpless0;
		my_sprites[$ "Magnet"	] = spr_hitlag0;
		my_sprites[$ "Flinch"	] = spr_crouch0;
		my_sprites[$ "Lag"		] = spr_crouch0;
		my_sprites[$ "Balloon"	] = spr_balloon0;
		my_sprites[$ "Reeling"	] = spr_reeling0;
		my_sprites[$ "Knockdown"] = anim_define_ext(spr_knockdown0, 2, 0.7, 1, 0, 1, 0, 0, false, anim_define_ext(spr_knockdown0, 6, 0));
		my_sprites[$ "Lock"		] = anim_define_ext(spr_knockdown0, 0, 0.5, 1, 0, 1, 0, 0, false, anim_define_ext(spr_knockdown0, 6, 0));
		my_sprites[$ "Getup"	] = anim_define_ext(spr_getup0, 0, anim_calculate_speed(spr_getup0, getup_active + getup_endlag));

		my_sprites[$ "Techroll"	] = spr_rolling0; 
		my_sprites[$ "Teching"	] = spr_teching0;
		my_sprites[$ "TechingW"	] = spr_teching0;
		my_sprites[$ "TechingC"	] = spr_teching0;
		my_sprites[$ "Techjump"	] = spr_wall_jump0;
			 
		my_sprites[$ "LedgeS"	] = spr_ledge_snap0;
		my_sprites[$ "Ledge"	] = spr_ledge_hang0;
		my_sprites[$ "LedgeG"	] = spr_ledge_getup0;
		my_sprites[$ "LedgeJ"	] = spr_ledge_jump0;
		my_sprites[$ "LedgeR"	] = spr_ledge_jump0;
		my_sprites[$ "LedgeA"	] = spr_ledge_attack_getup0;
		my_sprites[$ "LedgeT"	] = -1;
		my_sprites[$ "LedgeTr"	] = spr_ledge_trump0;
		my_sprites[$ "WallC"	] = spr_wall_cling0;
		my_sprites[$ "WallJ"	] = spr_wall_jump0;

		my_sprites[$ "StarKO"	] = spr_star_ko0;
		my_sprites[$ "ScreenKO"	] = spr_screen_ko0;
			 
		my_sprites[$ "Grabbing"	] = spr_grabbing0;
		my_sprites[$ "IsGrabbed"] = spr_hitstun0;
		my_sprites[$ "GrabRel"	] = spr_crouch0;
		}
}
/* Copyright 2023 Springroll Games / Yosi */