///@category Player Engine Scripts
/*
Initializes variables for <obj_player>.
All values here are default values only, and may be changed immediately after this function is called.
*/
function player_init_start() {
	//Character
	character = 0;
	character_script = -1;
	character_name = "";

	//State
	state = PLAYER_STATE.idle;
	state_script = -1;
	state_frame = 0;
	state_time = 0;
	state_phase = 0;
	state_facing = 0;

	//Player attributes
	player_number = 0;
	player_color = 0;
	player_outline_color = c_black;
	player_profile = 0;
	player_name = "";
	player_team = -1;

	//Other state variables
	jump_is_shorthop = false;
	jump_is_midair_jump = false;
	jump_is_dash_jump = false;
	dash_prevent_jump = false;
	can_fastfall = true;
	double_jumps = 1;
	landed_on_ground = false;
	footstool_cooldown = 0;
	airdodges_max = 1;
	airdodges = airdodges_max;
	airdodge_is_directional = false;
	airdodge_direction = 90;
	shield_shift_x = 0;
	shield_shift_y = 0;
	shield_hp = 999;
	shieldstun = 0;
	parry_stun_time = parry_press_stun_time_default;
	has_been_parried = false;
	heavyarmor_amount = 0.0;
	magnet_goal_x = 0;
	magnet_goal_y = 0;
	magnet_snap_speed = magnetbox_snap_speed_default;
	tech_buffer = tech_lockout_time;
	ledge_id = noone;
	ledge_grab_timeout = 0;
	ledge_grab_counter = 0;
	ledge_tether_point_id = noone;
	wall_cling_timeout = 0;
	wall_jump_timeout = 0;
	wall_jumps = 0;
	self_hitlag_frame = 0;
	attack_script = -1;
	attack_frame = 0;
	attack_phase = 0;
	simple_attack_name = "";
	charge = 0;
	landing_lag = 0;
	final_smash_uses = 0;
	grab_hold_x = 0;
	grab_hold_y = 0;
	grab_hold_enable = true;
	grab_hold_id = noone;
	grabbed_id = noone;
	grab_regrab_frame = 0;
	grab_break_buffer = grab_break_lockout_time;
	throw_stick_has_reset = false;
	ignore_blastzones = false;

	//Input cached values
	is_cpu = false;
	cpu_type = CPU_TYPE.attack;
	cpu_inputs_bitflag = 0;
	device = -1;
	device_type = DEVICE.none;
	double_tap_run_frame = 0;
	double_tap_fastfall_frame = 0;
	custom_controls = [];
	control_states_l = array_create(buffer_time_max * CONTROL_STICK.LENGTH, 0);
	control_states_r = array_create(buffer_time_max * CONTROL_STICK.LENGTH, 0);
	control_tilted_l = 0;
	control_tilted_r = 0;
	control_flicked_l = 0;
	control_flicked_r = 0;
	
	//Right stick input
	right_stick_input = INPUT.smash;
	
	//Special control settings
	scs = array_create(SCS.LENGTH, false);
	
	//Advanced controller settings
	acs = array_create(ACS.LENGTH, false);

	//Make an array to store the last few frames of input (input buffer)
	input_buffer = array_create(INPUT.LENGTH * 2, buffer_time_max);
	paused_inputs_flag = 0;
	
	//Speeds / Collisions
	speed_init();
	collision_flags = 0;
	collision_flag_set(id, FLAG.ride, true);
	collision_flag_set(id, FLAG.push, true);

	facing = (x != room_width div 2 ? sign(room_width div 2 - x) : 1); //Face the center of the stage

	//Damage / Knockback
	damage = 0;
	knockback_dir = 0;
	knockback_spd = 0;
	stored_hitstun = 0;
	stored_state = PLAYER_STATE.hitstun;
	is_reeling = false;
	asdi_multiplier = 1;
	drift_di_multiplier = 1;
	di_angle = di_default;
	ko_property = noone; //Determines SD's / normal KO's
	player_id = id;
	stock = setting().match_stock;
	points = 0; //Time no-stock matches
	stamina = setting().match_stamina;
	any_hitbox_has_hit = false;
	any_hitbox_has_been_blocked = false;
	can_hitfall = false;
	can_tech = true;
	combo_counter = 0;
	combo_target = noone;
	combo_break_timer = 0; //How many frames the target has been out of hitstun
	damage_attack_multiplier = 1.0; //All hitboxes created by this player will have their damage multiplied by this number
	damage_taken_multiplier = 1.0; //All hitboxes hitting this player will have their damage multiplied by this number
	knockback_multiplier = 1.0; //All hitboxes created by this player will have their base knockback multiplied by this number

	//My Hitboxes Array - Keeps track of all of the user's hitboxes
	my_hitboxes = [];
	//Hitbox Groups - Each group has an array that stores what has been hit
	//Two hitboxes in the same group cannot hit the same target
	//Prevents multi-hitbox moves from dealing massive damage
	hitbox_groups = array_create(hitbox_groups_max, undefined);
	for(var i = 0; i < hitbox_groups_max; i++)
		{
		hitbox_groups[@ i] = [];
		}
	
	//Shield hurtbox placeholder
	hurtbox_shield = noone;
	
	//Animation
	anim_current = -1 //Array of current animation, if any
	anim_sprite = -1;
	anim_frame = anim_frame_normal;
	anim_speed = anim_speed_normal;
	anim_angle = anim_angle_normal;
	anim_scale = anim_scale_normal;
	anim_alpha = anim_alpha_normal;
	anim_offsetx = anim_offset_normal;
	anim_offsety = anim_offset_normal;
	anim_loop = anim_loop_normal;
	anim_finish = anim_finish_normal;
	renderer = obj_player_renderer;
	invisible = false;
	fade_value = 1;
	flash_color = c_white;
	flash_alpha = 0;
	damage_text_random = 0;
	
	//Character property defaults
	airdodge_speed = -1;
	airdodge_startup = -1;
	airdodge_active = -1;
	airdodge_endlag = -1;
	waveland_speed_boost = -1;
	waveland_time = -1;
	waveland_friction = -1;
	airdodge_land_time = -1;
	airdodge_dir_windup_speed = -1;
	airdodge_dir_speed_min = -1;
	airdodge_dir_speed_max = -1;
	airdodge_dir_active = -1;
	airdodge_dir_endlag_min = -1;
	airdodge_dir_endlag_max = -1;
	airdodge_dir_grav = -1;
	shield_max_hp = -1;
	shield_depeletion_rate = -1;
	shield_recover_rate = -1;
	shield_break_launch = -1;
	shield_break_reset_hp = -1;
	shield_size_multiplier = -1;
	shield_shift_amount = -1;
	shield_release_time = -1;
	spot_dodge_startup = -1;
	spot_dodge_active = -1;
	spot_dodge_endlag = -1;
	parry_press_startup = -1;
	parry_press_active = -1;
	parry_press_endlag = -1;
	parry_press_trigger_time = -1;
	parry_press_script = -1;
	parry_ult_window = -1;
	parry_ult_freeze_time = -1;
	parry_ult_self_freeze_time = -1;
	parry_ult_sprite = -1;
	wall_jump_startup = 2;
	wall_jump_time = -1;
	wall_jump_hsp = -1;
	wall_jump_vsp = -1;
	max_wall_jumps = -1;
	can_wall_cling = false;
	can_wall_jump = false;

	//The state log is for debug use.
	//It keeps track of the states the object has been in.
	state_log = array_create(player_state_log_size, PLAYER_STATE.entrance);
	
	//Player States
	my_states = [];
	
	//Attacks and Sprites
	my_attacks = {};
	my_sprites = {};
	attack_cooldowns = {};
	attack_uses = {};
	
	//Items
	item_held = noone;
	item_hold_x = 0;
	item_hold_y = 0;
	item_visible = true;
	item_throw_direction = 0;
	
	//Custom Variables in Attacks & the Custom Script
	custom_attack_struct = {};
	custom_passive_struct = {};
	custom_ids_struct = {};
	
	//Custom callback scripts
	callback_passive = [];
	callback_hud = [];
	callback_overhead = [];
	callback_draw_begin = [];
	callback_draw_end = [];
	callback_hit = [];
	callback_hurt = [];
}
/* Copyright 2023 Springroll Games / Yosi */