///@category Hurtboxes
///@param {id} hurtbox_id			The hurtbox to change
///@param {id} hitbox_id			The instance id of the hitbox to copy properties from
/*
Copies the position, size, sprite, angle, and lifetime properties from the given hitbox.
Warning: This only works for hurtboxes with the type "HURTBOX_TYPE.attack", and attached hitboxes!
*/
function hurtbox_copy_hitbox() {
	var _hurtbox = argument[0];
	var _hitbox = argument[1];
	
	assert(object_is_ancestor(_hitbox.object_index, obj_hitbox_attached), "[hurtbox_copy_hitbox] The hitbox must be a child of obj_hitbox_attached");
	assert(_hurtbox.hurtbox_type == HURTBOX_TYPE.attack, "[hurtbox_copy_hitbox] The hurtbox must have the type HURTBOX_TYPE.attack");
	
	with(_hurtbox)
		{
		//Position
		x = _hitbox.x;
		y = _hitbox.y;
		xstart = _hitbox.xstart;
		ystart = _hitbox.ystart;
		owner_xstart = _hitbox.owner_xstart;
		owner_ystart = _hitbox.owner_ystart;
		
		//Size
		image_xscale = _hitbox.image_xscale;
		image_yscale = _hitbox.image_yscale;
		
		//Sprite
		sprite_index = _hitbox.sprite_index;
		
		//Angle
		image_angle = _hitbox.image_angle;
		
		//Lifetime
		lifetime = _hitbox.lifetime;
		}
}
/* Copyright 2023 Springroll Games / Yosi */