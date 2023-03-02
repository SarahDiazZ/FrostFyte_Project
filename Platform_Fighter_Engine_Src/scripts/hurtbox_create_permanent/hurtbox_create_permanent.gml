///@category Hurtboxes
///@param {asset} default_sprite		The sprite the hurtbox will use when <hurtbox_reset> is called
/*
Creates a new <obj_hurtbox>.
Permanent hurtboxes are always attached to the owner object and have infinite lifetime.
To create a non-permanent hurtbox, use <hurtbox_create>.
*/
function hurtbox_create_permanent() {
	var _hurtbox = instance_create_layer(x, y, layer, obj_hurtbox);
	with(_hurtbox)
		{
		owner = other.id;
		hurtbox_type = HURTBOX_TYPE.permanent;
		if (argument_count > 0)
			{
			sprite_index = argument[0];
			default_sprite = sprite_index;
			}
		}
	return _hurtbox;
}
/* Copyright 2023 Springroll Games / Yosi */