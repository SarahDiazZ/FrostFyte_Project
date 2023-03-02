///@category Hitboxes
///@param {id} hitbox				The hitbox to change the shape of	
///@param {int/asset} shape		The shape of the hitbox, either a property of the SHAPE enum or a sprite asset
/*
Changes the shape of a hitbox to a shape from the SHAPE enum or a sprite.
	- SHAPE.square: Uses spr_hitbox_square, a 64x64 square.
	- SHAPE.circle: Uses spr_hitbox_circle, a 64x64 circle.
	- SHAPE.rotation: Uses spr_hitbox_rotation, a 64x64 square that can be rotated with <hitbox_sprite_angle_set>.
*/
function hitbox_shape_set() {
	with(argument[0])
		{
		var _value = argument[1];
		if (_value == SHAPE.square)
			{
			sprite_index = spr_hitbox_square;
			}
		else if (_value == SHAPE.circle)
			{
			sprite_index = spr_hitbox_circle;
			}
		else if (_value == SHAPE.rotation)
			{
			sprite_index = spr_hitbox_rotation;
			}
		else if (sprite_exists(_value))
			{
			sprite_index = _value;
			image_xscale *= owner.facing;
			}
		else
			{
			crash("[hitbox_shape_set] Invalid shape (", _value, ")");
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */