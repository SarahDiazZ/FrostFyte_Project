///@category Attacking
///@param {int/real} damage					The attack's damage
///@param {real} shieldstun_scaling			The attack's shieldstun scaling
/*
Calculates how many frames a player is forced to stay shielding when hit by an attack with the given properties.
*/
function calculate_shieldstun() {
	var _dmg = argument[0];
	var _multi = argument[1];
	var _stun = ceil(max(0, (_dmg * shieldstun_multiplier_default * _multi) + shieldstun_time_min));
	
	//Visuals
	if (setting().show_shieldstun)
		{
		with(obj_notice)
			{
			if (custom_vfx_struct.color == c_fuchsia) then instance_destroy();
			}
		with(instance_create_layer(x, y - 16, layer, obj_notice))
			{
			custom_vfx_struct.color = c_fuchsia;
			custom_vfx_struct.text = string(_stun);
			lifetime = 60;
			}
		}
	
	return _stun;
}
/* Copyright 2023 Springroll Games / Yosi */