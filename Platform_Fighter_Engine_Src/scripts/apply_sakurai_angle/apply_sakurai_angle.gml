///@category Attacking
///@param {int} angle_flipper		The angle flipper of the attack
///@param {real} knockback			The amount of knockback in the attack
/*
Applies special properties of the sakurai angle to the calling player.
When a player is hit with a low knockback attack while on the ground, and the attack has the sakurai angle:
	- The player cannot DI
	- The player cannot ASDI
	- The player cannot tech
*/
function apply_sakurai_angle() {
	var _flipper = argument[0];
	var _knockback = argument[1];

	if (_flipper == FLIPPER.sakurai || _flipper == FLIPPER.sakurai_reverse)
		{
		if (_knockback < s_angle_knockback_threshold)
			{
			if (on_ground())
				{
				di_angle = 0;
				asdi_multiplier = 0;
				can_tech = false;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */