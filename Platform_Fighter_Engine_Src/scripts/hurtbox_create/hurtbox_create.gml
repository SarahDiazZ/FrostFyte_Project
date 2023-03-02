///@category Hurtboxes
///@param {int} rel_x						The relative x from the calling player
///@param {int} rel_y						The relative y from the calling player
///@param {real} xscale						The horizontal size scaling
///@param {real} yscale						The vertical size scaling
///@param {int} lifetime					How many frames the hurtbox will last
///@param {int/asset} shape					The shape of the hurtbox, either a property of the SHAPE enum or a sprite asset
///@param {int} inv_type					The invulnerability type of the hurtbox, from the INV enum
///@param {real} [sprite_angle]				The angle of the hitbox sprite
/*
Creates a new <obj_hurtbox>.
Hurtboxes created through this function are given the type HURTBOX_TYPE.attack, meaning they are temporary hurtboxes (unless the type is later changed).
You can create permanent hurtboxes with <hurtbox_create_permanent>.
*/
function hurtbox_create() {
	var _hurtbox = instance_create_layer(round(x + argument[0] * facing), round(y + argument[1]), layer, obj_hurtbox);
	with(_hurtbox)
		{
		owner = other.id;
		owner_xstart = other.x;
		owner_ystart = other.y;
		hurtbox_type = HURTBOX_TYPE.attack;
		image_xscale = argument[2];
		image_yscale = argument[3];
		lifetime = argument[4];
		hurtbox_shape_set(id, argument[5]);
		inv_type = argument[6];
		inv_frame = -1;
		inv_override = true;
		if (argument_count > 7) then hurtbox_sprite_angle_set(id, argument[7]);
		}
	return _hurtbox;
}
/* Copyright 2023 Springroll Games / Yosi */