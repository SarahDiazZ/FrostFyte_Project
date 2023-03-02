///@category Player Actions
/*
Respawns the calling player on the next available <obj_respawn_platform>.
If no platform is available, the player respawns at their starting coordinates in the room.
*/
function respawn() {
	//Stop the attack, if you are currently attacking
	attack_stop();
	hitbox_destroy_attached_all();
	
	//Reset values
	speed_set(0, 0, false, false);
	
	jump_is_shorthop = false;
	jump_is_midair_jump = false;
	jump_is_dash_jump = false;
	dash_prevent_jump = false;
	can_fastfall = true;
	double_jumps = max_double_jumps;
	landed_on_ground = false;
	airdodges = airdodges_max;
	shield_shift_x = 0;
	shield_shift_y = 0;
	shield_hp = shield_max_hp;
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
	wall_jumps = max_wall_jumps;
	self_hitlag_frame = 0;
	final_smash_uses = 0;
	grab_hold_x = 0;
	grab_hold_y = 0;
	grab_hold_enable = true;
	grab_hold_id = noone;
	grabbed_id = noone;
	grab_regrab_frame = 0;
	throw_stick_has_reset = false;
	
	damage = 0;
	knockback_dir = 0;
	knockback_spd = 0;
	stored_hitstun = 0;
	stored_state = PLAYER_STATE.hitstun;
	is_reeling = false;
	asdi_multiplier = 1;
	drift_di_multiplier = 1;
	di_angle = di_default;
	ko_property = noone;
	stamina = setting().match_stamina;
	can_tech = true;
	combo_counter = 0;
	combo_target = noone;
	combo_break_timer = 0;
	
	//Held Items
	if (item_held != noone)
		{
		with(item_held)
			{
			instance_destroy();
			}
		item_held = noone;
		item_visible = true;
		}
	item_hold_x = 0;
	item_hold_y = 0;
	item_throw_direction = 0;
	
	//Find the first open respawn platform
	if (instance_number(obj_respawn_platform) > 0)
		{
		var _current_respawning = 0;
		with(obj_player)
			{
			if (state == PLAYER_STATE.respawning)
				{
				_current_respawning++;
				}
			}
		var _platform = instance_find(obj_respawn_platform, _current_respawning);
		x = _platform.x;
		y = _platform.y - sprite_height;
		}
	else
		{
		x = xstart;
		y = ystart;
		}
		
	//Change state
	state_set(PLAYER_STATE.respawning);
}
/* Copyright 2023 Springroll Games / Yosi */