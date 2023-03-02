///@category Hurtboxes
///@param {id} hurtbox				The id of the hurtbox to change the invulnerability of
///@param {int} type				The invulnerability type to change to
///@param {int} time				How long to keep the new invulnerability
///@param {bool} [overridable]		If the new inverulnability can be overriden or not. The default is true	
/*
Sets the invulnerability of the given hurtbox.
If the given time is -1, the hurtbox will have that invulnerability indefinitely.
Essentially an advanced version of <invulnerability_set>.
Currently, the only time an invulnerability is not overridable is the respawn invincibility.
*/
function hurtbox_inv_set() {
	var _hurtbox = argument[0];
	var _type = argument[1];
	var _time = argument[2];
	var _override = argument_count > 3 ? argument[3] : true;

	with(_hurtbox)
		{
		if (inv_override || !_override)
			{
			inv_type = _type;
			inv_frame = _time;
			inv_override = _override;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */