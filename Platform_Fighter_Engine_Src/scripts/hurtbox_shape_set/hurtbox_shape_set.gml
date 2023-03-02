///@category Hurtboxes
///@param {id} hurtbox				The hurtbox to change the shape of
///@param {int/asset} shape		The shape of the hurtbox, either a property of the SHAPE enum or a sprite asset
/*
Changes the shape of a hurtbox to a shape from the SHAPE enum or a sprite.
*/
function hurtbox_shape_set() {
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
			crash("[hurtbox_shape_set] Invalid shape (", _value, ")");
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */