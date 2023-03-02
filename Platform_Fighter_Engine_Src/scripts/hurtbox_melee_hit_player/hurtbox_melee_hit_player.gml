///@category Hurtboxes
///@param {id} hitbox		The attacking hitbox
///@param {id} hurtbox		The hurtbox being hit
/*
Standard script for when an <obj_hitbox_melee> hits a player's hurtbox.
It is run from the owner of the hurtbox that was hit.
*/
function hurtbox_melee_hit_player() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	//Check restrictions
	if (!calculate_hit_restriction(_hitbox, _hurtbox)) then return;

	//Check invulnerability
	switch(_hurtbox.inv_type)
		{
		default:
		case INV.normal:
		case INV.heavyarmor:
			combo_register(_hitbox.owner, _hurtbox.owner);
			hitbox_register_hit(_hitbox, false, true);
			//Knockback and damage
			apply_damage(id, _hitbox.damage * _hurtbox.owner.damage_taken_multiplier);
			if (is_knocked_out()) then return;
			//Hitstun stored for later use when the hitlag ends
			stored_hitstun = calculate_hitstun(_hitbox.base_knockback, _hitbox.damage, weight_multiplier, damage, _hitbox.knockback_scaling, hitstun_multiplier * _hitbox.hitstun_scaling, _hitbox.custom_hitstun);
			//Stored knockback state
			stored_state = _hitbox.knockback_state;
			//ASDI
			asdi_multiplier = _hitbox.asdi_multiplier;
			//Drift DI
			drift_di_multiplier = _hitbox.drift_di_multiplier;
			//Max DI
			di_angle = _hitbox.di_angle;
			//Techable
			can_tech = _hitbox.techable;
			//Knockback and hitlag
			var _total_kb = calculate_knockback(damage, _hitbox.damage, weight_multiplier, _hitbox.knockback_scaling, _hitbox.base_knockback, _hitbox.knockback_formula);
			var _total_hl = calculate_hitlag(_hitbox.base_hitlag, damage, _hitbox.hitlag_scaling);
			//Calculate angle based on flipper
			var _calc_angle = apply_angle_flipper(_hitbox.angle, _hitbox.angle_flipper, _hitbox.owner, id, _total_kb, _hitbox.facing);
			apply_sakurai_angle(_hitbox.angle_flipper, _total_kb);
			//Heavyarmor
			if (_hurtbox.inv_type == INV.heavyarmor && _total_kb <= heavyarmor_amount)
				{
				//Hitlag
				_hitbox.owner.self_hitlag_frame = _hitbox.base_hitlag;
				self_hitlag_frame = _hitbox.base_hitlag;
				}
			//Normal
			else
				{
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
					attack_stop_ext(PLAYER_STATE.hitlag, false);
					//Check for finishing blow
					if (_hitbox.base_knockback != 0)
						{
						if (is_finishing_blow(_total_kb, _calc_angle, stored_hitstun, id) && _hitbox.background_clear_allow)
							{
							_total_hl += finishing_blow_hitlag_increase;
							var _vfx = vfx_create(spr_hit_final_hit, 1, 0, 36, x, y, 2, prng_number(0, 360));
							_vfx.vfx_blend = c_black;
							background_clear_activate(_total_hl, palette_color_get(_hitbox.owner.palette_data, 0), _calc_angle);
							}
						}
					apply_knockback(_calc_angle, _total_kb, _total_hl + _hitbox.extra_hitlag);
					//Reeling
					if (_hitbox.force_reeling || _total_kb > reeling_speed_threshold)
						{
						is_reeling = true;
						}
					//Turn around based on the knockback
					if (hit_turnaround && !hitlag_delay_animation)
						{
						var _diff = abs(angle_difference(_calc_angle, 0));
						if (_diff != 0)
							{
							facing = _diff < 90 ? -1 : 1;
							}
						}
					//Attacking player gets the same hitlag
					_hitbox.owner.self_hitlag_frame = _total_hl;
					}
				//Frame Advantage
				frame_advantage_start(_hitbox.owner, _total_hl + _hitbox.extra_hitlag + stored_hitstun);
				}
			//Effects
			hit_vfx_style_create(_hitbox.hit_vfx_style, _calc_angle, _hitbox, _total_kb);
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
		case INV.superarmor:
			hitbox_register_hit(_hitbox, false, true);
			//Just damage; no state change
			apply_damage(id, _hitbox.damage * _hurtbox.owner.damage_taken_multiplier);
			if (is_knocked_out()) then return;
			//Hitlag
			var _total_hl = calculate_hitlag(_hitbox.base_hitlag, damage, _hitbox.hitlag_scaling);
			_hitbox.owner.self_hitlag_frame = _total_hl;
			self_hitlag_frame = _total_hl;
			//Knockback
			var _total_kb = calculate_knockback(damage, _hitbox.damage, weight_multiplier, _hitbox.knockback_scaling, _hitbox.base_knockback);
			//Calculate angle based on flipper
			var _calc_angle = apply_angle_flipper(_hitbox.angle, _hitbox.angle_flipper, _hitbox.owner, id, _total_kb, _hitbox.facing);
			//Effects
			hit_vfx_style_create(_hitbox.hit_vfx_style, _calc_angle, _hitbox, _total_kb);
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
			//Deplete shield
			shield_hp -= _hitbox.custom_shield_damage != -1 ? _hitbox.custom_shield_damage : _hitbox.damage;
			shieldstun = max(shieldstun, calculate_shieldstun(_hitbox.damage, _hitbox.shieldstun_scaling));
			//Pushback
			if (shield_pushback_enable)
				{
				//Angle
				var _calc_angle = apply_angle_flipper(_hitbox.angle, _hitbox.angle_flipper, _hitbox.owner, id, s_angle_knockback_threshold, _hitbox.facing);
				//Setting speed
				hsp = calculate_shield_pushback(_hitbox.damage, _calc_angle, 1);
				}
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