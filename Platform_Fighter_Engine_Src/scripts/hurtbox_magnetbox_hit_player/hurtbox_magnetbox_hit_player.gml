///@category Hurtboxes
///@param {id} hitbox		The attacking hitbox
///@param {id] hurtbox		The hurtbox being hit
/*
Standard script for when an <obj_hitbox_magnetbox> hits a player's hurtbox.
It is run from the owner of the hurtbox that was hit.
*/
function hurtbox_magnetbox_hit_player() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	//Check restrictions
	if (!calculate_hit_restriction(_hitbox, _hurtbox)) then return;

	//Check invulnerability
	switch(_hurtbox.inv_type)
		{
		default:
		case INV.normal:
			combo_register(_hitbox.owner, _hurtbox.owner);
			hitbox_register_hit(_hitbox, false, true);
			//Knockback and damage
			apply_damage(id, _hitbox.damage * _hurtbox.owner.damage_taken_multiplier);
			if (is_knocked_out()) then return;
			//Locking
			if (_hitbox.can_lock && state == PLAYER_STATE.knockdown)
				{
				knockdown_lock();
				
				//Hitlag
				_hitbox.owner.self_hitlag_frame = _hitbox.base_hitlag;
				self_hitlag_frame = _hitbox.base_hitlag;
				}
			else
				{
				//Change state
				attack_stop_ext(PLAYER_STATE.magnetized, false);
				if (_hitbox.magnet_relative)
					{
					magnet_goal_x = round(_hitbox.owner.x + _hitbox.magnet_goal_x);
					magnet_goal_y = round(_hitbox.owner.y + _hitbox.magnet_goal_y);
					}
				else
					{
					magnet_goal_x = round(_hitbox.x + _hitbox.magnet_goal_x);
					magnet_goal_y = round(_hitbox.y + _hitbox.magnet_goal_y);
					}
				magnet_snap_speed = _hitbox.magnet_snap_speed;
				state_frame = _hitbox.state_frame + _hitbox.base_hitlag;
				//Attacking player gets some hitlag
				_hitbox.owner.self_hitlag_frame = _hitbox.base_hitlag;
				//Turn around based on the knockback
				if (hit_turnaround && !hitlag_delay_animation)
					{
					if (x != _hitbox.owner.x) then facing = sign(_hitbox.owner.x - x);
					}
				}
			//Frame Advantage
			frame_advantage_start(_hitbox.owner, state_frame);
			//Effects
			var _dir = point_direction(x, y, magnet_goal_x, magnet_goal_y);
			hit_vfx_style_create(_hitbox.hit_vfx_style, _dir, _hitbox, _hitbox.damage);
			hit_sfx_play(_hitbox.hit_sfx);
			//Callbacks
			with(_hitbox.owner)
				{
				if (object_is(object_index, obj_player)) then callback_run(callback_hit, [_hitbox, _hurtbox]);
				}
			callback_run(callback_hurt, [_hitbox, _hurtbox]);
			break;
		case INV.invincible:
			//No knockback or damage or hitlag
			//Do not add the player to the hitbox group array
			//This is because the opponent should be hit even if their invincibility runs out mid-attack
			break;
		case INV.heavyarmor:
		case INV.superarmor:
			hitbox_register_hit(_hitbox, false, true);
			//Just damage; no state change
			apply_damage(id, _hitbox.damage * _hurtbox.owner.damage_taken_multiplier);
			if (is_knocked_out()) then return;
			//Hitlag
			_hitbox.owner.self_hitlag_frame = _hitbox.base_hitlag;
			self_hitlag_frame = _hitbox.base_hitlag;
			//Effects
			hit_vfx_style_create(_hitbox.hit_vfx_style, point_direction(x, y, _hitbox.magnet_goal_x, _hitbox.magnet_goal_y), _hitbox, _hitbox.damage);
			hit_sfx_play(_hitbox.hit_sfx);
			//Callbacks
			with(_hitbox.owner)
				{
				if (object_is(object_index, obj_player)) then callback_run(callback_hit, [_hitbox, _hurtbox]);
				}
			callback_run(callback_hurt, [_hitbox, _hurtbox]);
			break;
		case INV.shielding:
			hitbox_register_hit(_hitbox, true, true);
			//Deplete other's shield
			shield_hp -= _hitbox.custom_shield_damage != -1 ? _hitbox.custom_shield_damage : _hitbox.damage;
			shieldstun = max(shieldstun, calculate_shieldstun(_hitbox.damage, _hitbox.shieldstun_scaling));
			//Hitlag
			var _hitlag = ceil(_hitbox.base_hitlag * shield_hitlag_multiplier);
			_hitbox.owner.self_hitlag_frame = _hitlag;
			self_hitlag_frame = _hitlag;
			//Effects
			hit_vfx_style_create(HIT_VFX.shield, 0, _hitbox, 0);
			hit_sfx_play(shield_hit_sound);
			break;
		case INV.powershielding:
			hitbox_register_hit(_hitbox, true, true);
			//Target can cancel their shield with no lag
			state_frame = 0;
			//Hitlag
			_hitbox.owner.self_hitlag_frame = _hitbox.base_hitlag;
			//Effects
			vfx_create(spr_hit_powershield, 1, 0, 16, x, y, 1, 0, "VFX_Layer_Below");
			vfx_create_action_lines(10, x, y, prng_number(0, 10));
			hit_sfx_play(snd_parry);
			break;
		case INV.parry_press:
			hitbox_register_hit(_hitbox, true, true);
			//Activate the player's parry
			parry_press_trigger(_hitbox, true, id);
			break;
		case INV.parry_shield:
			hitbox_register_hit(_hitbox, true, true);
			//Activate the player's parry
			parry_shield_trigger(_hitbox, true, id);
			break;
		case INV.counter:
			hitbox_register_hit(_hitbox, true, true);
			//Active the player's counter
			if (script_exists(attack_script))
				{
				script_execute(attack_script, PHASE.counter, _hitbox);
				}
			break;
		case INV.deactivate:
			hitbox_register_hit(_hitbox, false, true);
			//Hitlag
			_hitbox.owner.self_hitlag_frame = _hitbox.base_hitlag;
			self_hitlag_frame = _hitbox.base_hitlag;
			break;
		case INV.reflector:
			//No knockback or damage or hitlag
			//Does not register as a hit
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */