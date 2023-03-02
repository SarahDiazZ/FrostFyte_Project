function item_explosive_box_detectbox_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

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
			hitbox_register_hit(_hitbox);
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
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */