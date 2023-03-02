///@category Hurtboxes
///@param {id} hitbox		The attacking hitbox
///@param {id] hurtbox		The hurtbox being hit
/*
Template for making hurtbox hit scripts.
It is run from the owner of the hurtbox that was hit.
*/
function hurtbox_hit_script_template() {
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
			//Normal and heavyarmor can share code, since the only difference is knockback
			break;
		case INV.invincible:
			break;
		case INV.superarmor:
			break;
		case INV.shielding:
			break;
		case INV.powershielding:
			break;
		case INV.parry_press:
			break;
		case INV.parry_shield:
			break;
		case INV.counter:
			break;
		case INV.deactivate:
			break;
		case INV.reflector:
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */