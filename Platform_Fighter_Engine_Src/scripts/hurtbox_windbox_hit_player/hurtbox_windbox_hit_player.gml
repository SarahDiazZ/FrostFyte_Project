///@category Hurtboxes
///@param {id} hitbox		The attacking hitbox
///@param {id] hurtbox		The hurtbox being hit
/*
Standard script for when an <obj_hitbox_windbox> hits a player's hurtbox.
It is run from the owner of the hurtbox that was hit.
*/
function hurtbox_windbox_hit_player() {
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
		case INV.superarmor:
			if (_hitbox.windbox_multihit)
				{
				if (!array_contains(_hitbox.owner.hitbox_groups[@ _hitbox.hitbox_group], _hitbox))
					{
					hitbox_register_hit(_hitbox, false, true);
					}
				}
			else
				{
				hitbox_register_hit(_hitbox, false, true);
				}
			//Damage
			apply_damage(id, _hitbox.damage * _hurtbox.owner.damage_taken_multiplier);
			if (is_knocked_out()) then return;
			//Knockback
			var _total_kb = calculate_knockback(damage, _hitbox.damage, weight_multiplier, _hitbox.knockback_scaling, _hitbox.base_knockback);
			//Calculate angle based on flipper
			var _calc_angle = 90;
			_calc_angle = apply_angle_flipper(_hitbox.angle, _hitbox.angle_flipper, _hitbox.owner, id, _total_kb, _hitbox.facing);
			//Knockback is applied, unless there is zero knockback
			if (_hitbox.base_knockback != 0)
				{
				//Windbox push
				if (_hitbox.windbox_push)
					{
					//Manually move the player
					move_x(round(lengthdir_x(_total_kb, _calc_angle)));
					//Check if it is lifting the player
					if ((on_ground() && _hitbox.windbox_lift) || !on_ground())
						{
						move_y(false, round(lengthdir_y(_total_kb, _calc_angle)));
						}
					}
				//Windbox speed boost
				else
					{
					var _hsp = lengthdir_x(_total_kb, _calc_angle);
					var _vsp = lengthdir_y(_total_kb, _calc_angle);
					//No lift
					if (on_ground() && !_hitbox.windbox_lift)
						{
						speed_set(_hsp, 0, _hitbox.windbox_accelerate, true);
						//Max speed
						if (abs(hsp) > _hitbox.windbox_max_speed)
							{
							hsp = clamp(hsp, -_hitbox.windbox_max_speed, _hitbox.windbox_max_speed);
							}
						}
					else
						{
						//Set the speed
						speed_set(_hsp, _vsp, _hitbox.windbox_accelerate, _hitbox.windbox_accelerate);
						//Maximum speed
						if (_hitbox.windbox_max_speed > 0 && point_distance(0, 0, hsp,vsp) > _hitbox.windbox_max_speed)
							{
							var _dir = point_direction(0, 0, hsp, vsp);
							speed_set(lengthdir_x(_hitbox.windbox_max_speed, _dir), lengthdir_y(_hitbox.windbox_max_speed, _dir), false, false);
							}
						}
					}
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
		case INV.deactivate:
		case INV.reflector:
			//Windboxes have no effect on these invulnerability types
			break;
		case INV.parry_press:
		case INV.parry_shield:
		case INV.counter:
		case INV.shielding:
		case INV.powershielding:
			if (_hitbox.windbox_multihit)
				{
				if (!array_contains(_hitbox.owner.hitbox_groups[@ _hitbox.hitbox_group], _hitbox))
					{
					hitbox_register_hit(_hitbox, true, true);
					}
				}
			else
				{
				hitbox_register_hit(_hitbox, true, true);
				}
			//Knockback
			var _total_kb = calculate_knockback(damage, _hitbox.damage, weight_multiplier, _hitbox.knockback_scaling, _hitbox.base_knockback);
			//Calculate angle based on flipper
			var _calc_angle = apply_angle_flipper(_hitbox.angle, _hitbox.angle_flipper, _hitbox.owner, id, _total_kb, _hitbox.facing);
			//Knockback is applied, unless there is zero knockback
			if (_hitbox.base_knockback != 0)
				{
				//Windbox push
				if (_hitbox.windbox_push)
					{
					//Manually move the player
					move_x(lengthdir_x(_total_kb, _calc_angle));
					//Don't lift the player
					if (!on_ground())
						{
						move_y(false, lengthdir_y(_total_kb, _calc_angle));
						}
					}
				//Windbox speed boost
				else
					{
					var _hsp = lengthdir_x(_total_kb, _calc_angle);
					var _vsp = lengthdir_y(_total_kb, _calc_angle);
					//No lift on ground
					if (on_ground())
						{
						speed_set(_hsp, 0, _hitbox.windbox_accelerate, true);
						//Max speed
						if (abs(hsp) > _hitbox.windbox_max_speed)
							{
							hsp = clamp(hsp, -_hitbox.windbox_max_speed, _hitbox.windbox_max_speed);
							}
						}
					else
						{
						//Set the speed
						speed_set(_hsp, _vsp, _hitbox.windbox_accelerate, _hitbox.windbox_accelerate);
						//Maximum speed
						if (_hitbox.windbox_max_speed > 0 && point_distance(0, 0, hsp,vsp) > _hitbox.windbox_max_speed)
							{
							var _dir = point_direction(0, 0, hsp, vsp);
							speed_set(lengthdir_x(_hitbox.windbox_max_speed, _dir), lengthdir_y(_hitbox.windbox_max_speed, _dir), false, false);
							}
						}
					}
				}
			//Effects
			hit_vfx_style_create(_hitbox.hit_vfx_style, _calc_angle, _hitbox, _total_kb);
			hit_sfx_play(_hitbox.hit_sfx);
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */