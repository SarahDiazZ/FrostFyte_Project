///@category Attacking
///@param {int} [attack_phase]				A specific phase of the attack to run		
/*
This is a special attack script that will run the player's currently assigned simple attack.
A simple attack can be assigned through <attack_start> if the name of the simple attack is passed instead of a script.
Sipmle attacks must be defined through <simple_attack_define>.
Warning: This should NOT be assigned directly to any characters! The simple attack name as a string should be assigned instead.
*/
function simple_attack_runner() {
	var run = true;
	var _name = simple_attack_name;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	var _data = simple_attack_data();
	assert(variable_struct_exists(_data, _name), "[simple_attack_runner] No simple attack exists with the name ", _name);
	
	//Get the stored simple attack data
	var _struct = _data[$ _name];
	assert(variable_struct_exists(_struct, "windows"), "[simple_attack_runner] No 'windows' property exists in the struct for ", _name);
	assert(variable_struct_exists(_struct, "sprite"), "[simple_attack_runner] No 'sprite' property exists in the struct for ", _name);
	var _windows = _struct[$ "windows"];
	var _sprite = _struct[$ "sprite"];
	var _preset = variable_struct_exists(_struct, "preset") ? _struct[$ "preset"] : SIMPLE_ATTACK_PRESET.none;
	var _type = variable_struct_exists(_struct, "type") ? _struct[$ "type"] : "both";
	var _movement = variable_struct_exists(_struct, "movement") ? _struct[$ "movement"] : "all";
	var _hurtbox = variable_struct_exists(_struct, "hurtbox") ? _struct[$ "hurtbox"] : noone;
	var _state_end = variable_struct_exists(_struct, "state_end") ? _struct[$ "state_end"] : undefined;
	var _vars = variable_struct_exists(_struct, "vars") ? _struct[$ "vars"] : undefined;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Speeds & Cancels
	switch(_type)
		{
		case "both":
			if (on_ground())
				{
				friction_gravity(ground_friction, grav, max_fall_speed);
				}
			else
				{
				friction_gravity(air_friction, grav, max_fall_speed);
				aerial_drift();
				}
			break;
		case "ground":
			friction_gravity(ground_friction, grav, max_fall_speed);
			if (cancel_air_check()) then run = false;
			break;
		case "air":
			friction_gravity(air_friction, grav, max_fall_speed);
			
			//Aerials
			if (_preset == SIMPLE_ATTACK_PRESET.aerial)
				{
				aerial_drift();
				allow_hitfall();
				fastfall_attack_try();
				}
			
			if (cancel_ground_check()) then run = false;
			break;
		default: crash("[simple_attack_runner] Invalid type string (", _type, ")");
		}
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			//Start Phase
			case PHASE.start:
				{
				//Starting animation
				anim_sprite = _sprite;
				anim_speed = 0;
				anim_frame = 0;
			
				//Variables
				if (!is_undefined(_vars))
					{
					var _var_names = variable_struct_get_names(_vars);
					for(var i = 0; i < array_length(_var_names); i++)
						{
						variable_instance_set(id, _var_names[@ i], _vars[$ _var_names[@ i]]);
						}
					}
				
				//Aerial Speed Boost
				if (_preset == SIMPLE_ATTACK_PRESET.aerial) then speed_set(0, -1, true, true);
					
				//Special Reverse B
				if (_preset == SIMPLE_ATTACK_PRESET.special) then reverse_b();
				
				//Start the first window
				var _window = _windows[@ 0];
				assert(variable_struct_exists(_window, "length"), "[simple_attack_runner] No 'length' property exists in the struct for window 0");
				attack_phase = 0;
				attack_frame = _window[$ "length"];
				
				//Hurtbox
				if (_hurtbox != noone) then hurtbox_anim_match(_hurtbox);
				
				return;
				}
			//Windows
			default:
				{
				var _window = _windows[@ attack_phase];
				assert(variable_struct_exists(_window, "length"), "[simple_attack_runner] No 'length' property exists in the struct for window ", attack_phase);
				var _total_window_length = _window[$ "length"];
				if (variable_struct_exists(_window, "whiff_lag"))
					{
					_total_window_length += (attack_connected() ? 0 : _window[$ "whiff_lag"]);
					}
					
				//Special B Reverse
				if (_preset == SIMPLE_ATTACK_PRESET.special && state_time == 5) then b_reverse();
				
				//Animation
				if (variable_struct_exists(_window, "anim_start"))
					{
					if (variable_struct_exists(_window, "anim_end"))
						{
						anim_frame = round(lerp(_window[$ "anim_start"], _window[$ "anim_end"], 1 - (attack_frame / _total_window_length)));
						}
					else
						{
						anim_frame = _window[$ "anim_start"];
						}
					}
					
				//Variables
				if (variable_struct_exists(_window, "vars"))
					{
					var _vars = _window[$ "vars"];
					var _var_names = variable_struct_get_names(_vars);
					for(var i = 0; i < array_length(_var_names); i++)
						{
						variable_instance_set(id, _var_names[@ i], _vars[$ _var_names[@ i]]);
						}
					}
					
				//Speed
				if (attack_frame == (_total_window_length - 1) && variable_struct_exists(_window, "speed"))
					{
					var _speed = _window[$ "speed"];
					speed_set(_speed[@ 0] * facing, _speed[@ 1], _speed[@ 2], _speed[@ 3]);
					}
					
				//Hitboxes
				if (variable_struct_exists(_window, "hitboxes"))
					{
					//Throw Superarmor
					if (_preset == SIMPLE_ATTACK_PRESET.a_throw)
						{
						invulnerability_set(INV.superarmor, 1);
						}
					
					var _hitboxes = _window[$ "hitboxes"];
					for(var i = 0; i < array_length(_hitboxes); i++)
						{
						var _hitbox = _hitboxes[@ i];
						
						//Create hitboxes
						var _frame = variable_struct_exists(_hitbox, "frame") ? _hitbox[$ "frame"] : 0;
							
						if (_total_window_length + (-attack_frame) + (-1) == _frame)
							{
							//Get hitbox properties from the struct
							assert(variable_struct_exists(_hitbox, "type"), "[simple_attack_runner] No 'type' property exists in the struct for window ", attack_phase, ", hitbox ", i);
							var _type = _hitbox[$ "type"];
							assert(variable_struct_exists(_hitbox, "args"), "[simple_attack_runner] No 'args' property exists in the struct for window ", attack_phase, ", hitbox ", i);
							var _a = _hitbox[$ "args"];
							var _a_len = array_length(_a);
							var _hitbox_id = noone;
							
							switch(_type)
								{
								case "melee":
									_hitbox_id = hitbox_create_melee(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _a[@ 4], _a[@ 5], _a[@ 6], _a[@ 7], _a[@ 8], _a[@ 9], _a[@ 10], _a[@ 11], 
										_a_len > 12 ? _a[@ 12] : undefined);
									break;
								case "projectile":
									_hitbox_id = hitbox_create_projectile(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _a[@ 4], _a[@ 5], _a[@ 6], _a[@ 7], _a[@ 8], _a[@ 9], _a[@ 10], _a[@ 11], 
										_a_len > 12 ? _a[@ 12] : undefined);
									break;
								case "windbox":
									_hitbox_id = hitbox_create_windbox(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _a[@ 4], _a[@ 5], _a[@ 6], _a[@ 7], _a[@ 8], _a[@ 9], 
										_a_len > 10 ? _a[@ 10] : undefined,
										_a_len > 11 ? _a[@ 11] : undefined,
										_a_len > 12 ? _a[@ 12] : undefined,
										_a_len > 13 ? _a[@ 13] : undefined,
										_a_len > 14 ? _a[@ 14] : undefined,
										_a_len > 15 ? _a[@ 15] : undefined);
									break;
								case "magnetbox":
									_hitbox_id = hitbox_create_magnetbox(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _a[@ 4], _a[@ 5], _a[@ 6], _a[@ 7], _a[@ 8], _a[@ 9], _a[@ 10], _a[@ 11], 
										_a_len > 12 ? _a[@ 12] : undefined);
									break;
								case "grab":
									_hitbox_id = hitbox_create_grab(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _a[@ 4], _a[@ 5], _a[@ 6], _a[@ 7]);
									break;
								case "pummel":
									_hitbox_id = hitbox_create_targetbox(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _a[@ 4], _a[@ 5], _a[@ 6], _a[@ 7], _a[@ 8], _a[@ 9], _a[@ 10], _a[@ 11], grabbed_id,
										_a_len > 12 ? _a[@ 12] : undefined);
									_hitbox_id.knockback_state = PLAYER_STATE.is_grabbed;
									break;
								case "throw":
									_hitbox_id = hitbox_create_targetbox(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _a[@ 4], _a[@ 5], _a[@ 6], _a[@ 7], _a[@ 8], _a[@ 9], _a[@ 10], _a[@ 11], grabbed_id,
										_a_len > 12 ? _a[@ 12] : undefined);
									break;
								case "smash":
									var _damage = calculate_smash_damage(_a[@ 4], charge, smash_attack_charge_max);
									_hitbox_id = hitbox_create_melee(_a[@ 0], _a[@ 1], _a[@ 2], _a[@ 3], _damage, _a[@ 5], _a[@ 6], _a[@ 7], _a[@ 8], _a[@ 9], _a[@ 10], _a[@ 11], 
										_a_len > 12 ? _a[@ 12] : undefined);
									break;
								default: crash("[simple_attack_runner] Invalid hitbox type string (", _type, ") for window ", attack_phase, ", hitbox ", i);
								}
								
							//Hitbox vars
							if (variable_struct_exists(_hitbox, "vars"))
								{
								var _vars = _hitbox[$ "vars"];
								var _var_names = variable_struct_get_names(_vars);
								for(var m = 0; m < array_length(_var_names); m++)
									{
									variable_instance_set(_hitbox_id, _var_names[@ m], _vars[$ _var_names[@ m]]);
									}
								}
								
							//Animation
							if (variable_struct_exists(_hitbox, "anim_frame"))
								{
								anim_frame = _hitbox[$ "anim_frame"];
								}
								
							//Overlay sprite
							if (variable_struct_exists(_hitbox, "overlay_sprite"))
								{
								_hitbox_id.overlay_sprite = _hitbox[$ "overlay_sprite"];
								_hitbox_id.overlay_facing = facing;
								}
							}
						}
					}
					
				//Hitbox group reset
				if (variable_struct_exists(_window, "reset_hitbox_groups"))
					{
					if (_window[$ "reset_hitbox_groups"]) then hitbox_group_reset_all();
					}
					
				//Throw Position
				if (_preset == SIMPLE_ATTACK_PRESET.a_throw && variable_struct_exists(_window, "throw_position"))
					{
					var _pos = _window[$ "throw_position"];
					grabbed_id.grab_hold_x = _pos[@ 0];
					grabbed_id.grab_hold_y = _pos[@ 1];
					grab_snap_move();
					}
				
				//Next window
				if (attack_frame <= 0)
					{
					//Charging
					var _charge = variable_struct_exists(_window, "charge") ? _window[$ "charge"] : -1;
					if ((!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)) || charge >= _charge)
						{
						charge = _charge;
						attack_phase++;
						if (attack_phase < array_length(_windows))
							{
							_window = _windows[@ attack_phase];
							assert(variable_struct_exists(_window, "length"), "[simple_attack_runner] No 'length' property exists in the struct for window ", attack_phase);
							attack_frame = _window[$ "length"];
							if (variable_struct_exists(_window, "whiff_lag"))
								{
								attack_frame += (attack_connected() ? 0 : _window[$ "whiff_lag"]);
								}
							}
						else
							{
							//Pummel Ending
							if (_preset == SIMPLE_ATTACK_PRESET.pummel)
								{
								var _grab_frame = state_frame;
								attack_stop(PLAYER_STATE.grabbing);
								state_frame = _grab_frame;
								//No need to reset the control stick after a pummel
								throw_stick_has_reset = true;
								}
							//Normal Endings
							else if (!is_undefined(_state_end))
								{
								attack_stop(_state_end);
								}
							else
								{
								attack_stop();
								}
							run = false;
							break;
							}
						}
					else
						{
						//Charge hold
						charge++;
						//Shine VFX
						if (charge % 8 == 0)
							{
							vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
							}
						}
					}
				break;
				}
			}
		}
		
	//Hurtbox
	if (run)
		{
		if (_hurtbox != noone) then hurtbox_anim_match(_hurtbox);
		}
		
	//Movement
	switch(_movement)
		{
		case "all":
			move();
			break;
		case "ground":
			move_grounded();
			break;
		case "hit_platforms":
			move_hit_platforms();
			break;
		case "through_platforms":
			move_through_platforms();
			break;
		default: crash("[simple_attack_runner] Invalid movement string (", _movement, ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */