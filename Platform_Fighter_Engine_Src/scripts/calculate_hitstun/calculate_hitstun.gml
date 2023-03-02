///@category Attacking
///@param {real} base_knockback			The base knockback
///@param {int} damage					The damage
///@param {real} weight					The target player's weight
///@param {int} target_damage			The target player's damage
///@param {real} knockback_scaling		The knockback scaling			
///@param {real} hitstun_multiplier		The hitstun multiplier
///@param {int} [custom_hitstun]		The custom hitstun amount
/*
Calculates the number of frames of hitstun a player would have if hit by an attack with the given values.
If a custom_hitstun value is given, that value is returned unchanged.
*/
function calculate_hitstun() {
	var _b = argument[0];
	var _d = argument[1];
	var _w = argument[2];
	var _hp = argument[3];
	var _s = argument[4];
	var _m = argument[5];
	var _c = argument_count > 6 ? argument[6] : -1;

	//Custom
	if (_c != -1) then return _c;
	
	//Formula
	switch(hitstun_type)
		{
		case HITSTUN_TYPE.normal:
			return ceil
				(
				(_b * hitstun_base_multiplier * ((_w - 1) * hitstun_weight_multiplier + 1)) + 
				(_d * hitstun_damage_multiplier * _s * hitstun_knockback_multiplier * _m * _w) +
				(lerp(0, hitstun_hp_increase_max, _hp / damage_max)),
				);
		case HITSTUN_TYPE.previous:
			return ceil
				(
				_b * hitstun_base_multiplier * ((_w - 1) * hitstun_weight_multiplier + 1) + 
				_d * hitstun_damage_multiplier * _s * hitstun_knockback_multiplier * _m * _w,
				);
		case HITSTUN_TYPE.damage_scaled:
			return ceil
				(
				((_b * hitstun_base_multiplier * ((_w - 1) * hitstun_weight_multiplier + 1)) + 
				(_hp * hitstun_damage_multiplier * _s * hitstun_knockback_multiplier)) * _m,
				);
		case HITSTUN_TYPE.simple:
			return ceil((_b * _w) + (_hp * _d * _s) * _m);
		}
}
/* Copyright 2023 Springroll Games / Yosi */