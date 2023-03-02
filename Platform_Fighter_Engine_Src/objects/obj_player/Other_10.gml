///@description STEP <Run by obj_game>

var _frozen = false;

//<input_update> is now called in <Advance_Game_Frame>!

//Teching & Grab Breaking
if (tech_buffer >= tech_lockout_time)
	{
	if (state == PLAYER_STATE.hitlag || 
		state == PLAYER_STATE.hitstun || 
		state == PLAYER_STATE.balloon || 
		state == PLAYER_STATE.tumble)
		{
		if (input_pressed(INPUT.shield, buffer_time_standard, false))
			{
			tech_buffer = 0;
			}
		}
	}
else
	{
	tech_buffer++;
	}
	
if (grab_break_enable)
	{
	if (grab_break_buffer >= grab_break_lockout_time)
		{
		if (input_pressed(INPUT.grab, buffer_time_standard, false))
			{
			grab_break_buffer = 0;
			}
		}
	else
		{
		grab_break_buffer++;
		}
	}

//Apply self hitlag, unless the player is in the hitlag state
if (self_hitlag_frame > 0 && state != PLAYER_STATE.hitlag)
	{
	self_hitlag_frame--;
	hitfall_try();
	_frozen = true;
	}
else
	{
	self_hitlag_frame = 0;
	}
	
//Collision Box
if (facing != 0)
	{
	image_xscale = sign(facing);
	}

//State Machine
if (!_frozen)
	{
	if (script_exists(state_script))
		{
		state_frame = max(0, --state_frame);
		state_time++;
		script_execute(state_script, PLAYER_STATE_PHASE.normal);
		}
	else crash("[obj_player: User Event 0] The player's state_script does not exist! (", state_script, ")");
	}
	
//Passive
callback_run(callback_passive);

//Resetting the jump counter / airdodge counter / wall jumps / ledge counter
if (on_ground() && vsp >= 0)
	{
	double_jumps = max_double_jumps;
	airdodges = airdodges_max;
	ledge_grab_counter = 0;
	//Restore wall jump
	if (wall_jump_type == WALL_JUMP_TYPE.jump_press)
		{
		wall_jumps = max_wall_jumps;
		wall_jump_timeout = 0;
		wall_cling_timeout = 0;
		}
	//Reset KO property
	if (state != PLAYER_STATE.hitlag && 
		state != PLAYER_STATE.hitstun && 
		state != PLAYER_STATE.balloon)
		{
		ko_property = noone;
		}
	}
	
//Resetting fastfalling
//It gets set to false after dropping through platforms
if (stick_get_value(Lstick, DIR.down) < stick_tilt_amount)
	{
	//Delete stick flicked input
	stick_flicked(Lstick, DIR.down, fastfall_buffer_time, true);
	can_fastfall = true;
	}
	
//Shield Regeneration
if (state != PLAYER_STATE.shielding && state != PLAYER_STATE.shield_break)
	{
	if (shield_type == SHIELD_TYPE.perfect_shield_start || shield_type == SHIELD_TYPE.parry_shield)
		{
		shield_hp = min(shield_hp + shield_recover_rate, shield_max_hp);
		}
	}
	
//Attack cooldown
var _cooldowns = variable_struct_get_names(attack_cooldowns);
for(var i = 0; i < array_length(_cooldowns); i++)
	{
	attack_cooldowns[$ _cooldowns[@ i]] = max(attack_cooldowns[$ _cooldowns[@ i]] - 1, 0);
	}
	
//Combo counter
if (combo_target != noone)
	{
	if (combo_target.state != PLAYER_STATE.balloon &&
		combo_target.state != PLAYER_STATE.flinch &&
		combo_target.state != PLAYER_STATE.hitlag &&
		combo_target.state != PLAYER_STATE.hitstun &&
		combo_target.state != PLAYER_STATE.is_grabbed &&
		combo_target.state != PLAYER_STATE.knockdown &&
		combo_target.state != PLAYER_STATE.magnetized)
		{
		combo_break_timer++;
		if (combo_break_timer >= combo_counter_break_frame)
			{
			combo_break_timer = 0;
			combo_counter = 0;
			combo_target = noone;
			}
		}
	}
	
//Frame Advantage
if (setting().show_frame_advantage)
	{
	if (!variable_struct_exists(custom_passive_struct, "frame_advantage_value"))
		{
		custom_passive_struct.frame_advantage_value = 0;
		}
	if (!variable_struct_exists(custom_passive_struct, "frame_advantage_count"))
		{
		custom_passive_struct.frame_advantage_count = false;
		}
	if (custom_passive_struct.frame_advantage_count)
		{
		custom_passive_struct.frame_advantage_value -= 1;
		}
		
	//Stop counting frame advantage when the player is in an "actionable" state
	if (state != PLAYER_STATE.attacking &&
		state != PLAYER_STATE.in_lag &&
		!is_launched() && 
		!is_knocked_out())
		{
		frame_advantage_stop();
		}
	}

//Ledge grab timeout
ledge_grab_timeout = max(--ledge_grab_timeout, 0);

//Wall Cling timeout
wall_cling_timeout = max(--wall_cling_timeout, 0);

//Wall Jump timeout
wall_jump_timeout = max(--wall_jump_timeout, 0);

//Regrab Frame
grab_regrab_frame = max(--grab_regrab_frame, 0);

//Footstool Cooldown
footstool_cooldown = max(--footstool_cooldown, 0);

//Animate sprite
if (!_frozen)
	{
	anim_frame += anim_speed;
	if (anim_frame > sprite_get_number(anim_sprite))
		{
		//Either loop or move onto the "finish" animation
		if (anim_loop)
			{
			anim_frame -= sprite_get_number(anim_sprite);
			}
		else if (is_array(anim_finish))
			{
			anim_set(anim_finish, true);
			}
		else
			{
			anim_frame = sprite_get_number(anim_sprite) - 1;
			}
		}
	}
	
//Held Items
if (item_held != noone && !instance_exists(item_held))
	{
	item_held = noone;
	}

//Visual Effects
damage_text_random *= 0.9;
if (damage_text_random < 0.1) then damage_text_random = 0.0;

if (!background_is_cleared())
	{
	fade_value = min(fade_value + 0.1, 1);
	}
	
flash_alpha = max(flash_alpha - 0.1, 0);

//Final Smash Glow
if (final_smash_uses > 0 && !is_knocked_out())
	{
	if (obj_game.current_frame % 8 == 0)
		{
		var _vfx = vfx_create(spr_glow_final_smash, 1, 0, 26, x, y, 2, 0, "VFX_Layer_Below");
		_vfx.vfx_xscale = prng_choose(0, -2, 2);
		_vfx.vfx_blend = make_color_hsv(prng_number(1, 255), prng_number(2, 200, 50), 255);
		_vfx.important = true;
		_vfx.follow = id;
		var _w = sprite_get_width(sprite_index);
		var _h = sprite_get_height(sprite_index) div 2;
		_vfx.follow_offset_x = prng_number(3, _w, -_w);
		_vfx.follow_offset_y = prng_number(4, _h, -_h);
		}
			
	flash_color = c_white;
	flash_alpha = 0.5 + (dsin(obj_game.current_frame * 5) * 0.25);
	
	obj_stage_manager.background_fog_color = c_black;
	obj_stage_manager.background_fog_alpha = max(0.5, obj_stage_manager.background_fog_alpha);
	}
	
//Safety Checks
assert(frac(x) == 0 && frac(y) == 0, "[obj_player: User Event 0] Player ", player_number, " does not have integer coordinates! ", x, ",", y, ". State: ", state);
assert(state_frame >= 0, "[obj_player: User Event 0] State Frame cannot be negative!");
assert(state_time >= 0, "[obj_player: User Event 0] State Time cannot be negative!");
assert(attack_frame >= 0, "[obj_player: User Event 0] Attack Frame cannot be negative!");
assert(frac(di_angle) == 0, "[obj_player: User Event 0] DI angle cannot be a float!");
assert(di_angle >= 0, "[obj_player: User Event 0] DI angle cannot be negative!");
assert(anim_frame >= 0, "[obj_player: User Event 0] Anim Frame cannot be negative!");
assert(frac(anim_offsetx) == 0, "[obj_player: User Event 0] Anim Offset X cannot be a float!");
assert(frac(anim_offsety) == 0, "[obj_player: User Event 0] Anim Offset Y cannot be a float!");
/* Copyright 2023 Springroll Games / Yosi */