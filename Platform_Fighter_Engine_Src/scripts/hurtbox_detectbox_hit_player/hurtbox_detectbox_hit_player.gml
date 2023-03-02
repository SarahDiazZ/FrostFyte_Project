///@category Hurtboxes
///@param {id} hitbox		The attacking hitbox
///@param {id] hurtbox		The hurtbox being hit
/*
Standard script for when an <obj_hitbox_detectbox> hits a player's hurtbox.
It is run from the owner of the hurtbox that was hit.
*/
function hurtbox_detectbox_hit_player() {
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
		case INV.counter:
		case INV.shielding:
		case INV.powershielding:
		case INV.parry_press:
		case INV.parry_shield:
		case INV.invincible:
		case INV.deactivate:
		case INV.reflector:
			if (!is_knocked_out())
				{
				hitbox_register_hit(_hitbox, false, true, !_hitbox.detect_multihit);
				//Run the attack's detection phase
				with(_hitbox.owner) 
					{
					if (script_exists(_hitbox.detect_script))
						{
						script_execute(_hitbox.detect_script, other.id, _hitbox, _hurtbox);
						}
					else if (script_exists(_hitbox.owner.attack_script))
						{
						script_execute(_hitbox.owner.attack_script, PHASE.detection, other.id, _hitbox, _hurtbox);
						}
					}
				}
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */