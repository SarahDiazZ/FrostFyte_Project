///@category Hitboxes
///@param {id} hitbox_id			The hitbox to change
///@param {id} hurtbox_id			The instance id of the hurtbox to copy properties from
/*
Copies the position, size, sprite, angle, and lifetime properties from the given hurtbox.
Warning: This only works for attached hitboxes, and hurtboxes with the type "HURTBOX_TYPE.attack"!
*/
function hitbox_copy_hurtbox() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	
	assert(object_is_ancestor(_hitbox.object_index, obj_hitbox_attached), "[hitbox_copy_hurtbox] The hitbox must be a child of obj_hitbox_attached");
	assert(_hurtbox.hurtbox_type == HURTBOX_TYPE.attack, "[hitbox_copy_hurtbox] The hurtbox must have the type HURTBOX_TYPE.attack");
	
	with(_hitbox)
		{
		//Position
		x = _hurtbox.x;
		y = _hurtbox.y;
		xstart = _hurtbox.xstart;
		ystart = _hurtbox.ystart;
		owner_xstart = _hurtbox.owner_xstart;
		owner_ystart = _hurtbox.owner_ystart;
		
		//Size
		image_xscale = _hurtbox.image_xscale;
		image_yscale = _hurtbox.image_yscale;
		
		//Sprite
		sprite_index = _hurtbox.sprite_index;
		
		//Angle
		image_angle = _hurtbox.image_angle;
		
		//Lifetime
		lifetime = _hurtbox.lifetime;
		}
}
/* Copyright 2023 Springroll Games / Yosi */