///@category Attacking
///@param {int/real} target_damage		The target player's damage
///@param {int/real} damage				The damage of the attack
///@param {real} target_weight			The target player's weight
///@param {real} scaling				The knockback scaling
///@param {real} base_knockback			The base knockback
///@param {int} [formula]				The knockback formula to use, from the KNOCKBACK_FORMULA enum
/*
Calculates the amount of knockback a player would take when hit by a move with the given properties.
*/
function calculate_knockback() {
	var _target_damage, _damage, _target_weight, _scaling, _knockback, _formula;
	_target_damage = argument[0];
	_damage = argument[1];
	_target_weight = argument[2];
	_scaling = argument[3];
	_knockback = argument[4];
	_formula = argument_count > 5 ? argument[5] : KNOCKBACK_FORMULA.standard;

	/*Target HP is the damage percent the target has after the attack hits*/
	switch(_formula)
		{
		default:
		case KNOCKBACK_FORMULA.standard:
			if (match_has_stamina_set() && !setting().match_screen_wrap)
				{
				return min(_knockback * _target_weight, knockback_max);
				}
			else
				{
				return  min(_knockback + (_target_damage + _damage) * _scaling * knockback_scaling_multiplier * _target_weight, knockback_max);
				}
			break;
		case KNOCKBACK_FORMULA.stronger:
			if (match_has_stamina_set() && !setting().match_screen_wrap)
				{
				return min(_knockback * _target_weight, knockback_max);
				}
			else
				{
				return  min(_knockback + (power((_target_damage + _damage) / 25, 1 + _scaling) * _target_weight), knockback_max);
				}
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */