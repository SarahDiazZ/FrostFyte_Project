//The pre_hit_script for uair_mario hitboxes that scales the hitstun of the attack based on the current combo
function uair_mario_pre_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	if (combo_counter == 0)
		{
		//Normal hitstun
		_hitbox.hitstun_scaling = 5;
		}
	else if (combo_counter == 1)
		{
		_hitbox.hitstun_scaling = 3;
		}
	else if (combo_counter == 2)
		{
		_hitbox.hitstun_scaling = 2;
		}
	else if (combo_counter == 3)
		{
		_hitbox.hitstun_scaling = 1;
		}
	else if (combo_counter == 4)
		{
		_hitbox.hitstun_scaling = 0.75;
		}
	else
		{
		_hitbox.hitstun_scaling = 0.5;
		}
		
}
/* Copyright 2023 Springroll Games / Yosi */