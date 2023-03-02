///@category Hitboxes
///@param {id} hitbox				The hitbox to change the sprite angle of
///@param {real} angle				The angle, assuming the hitbox is facing right
///@param {bool} [exact_angle]		Whether to flip the angle based on the direction the player is facing or not
/*
Sets the angle of a hitbox with the shape "SHAPE.rotation". The angle will be adjusted based on the direction the player is facing, unless exact angle is set to true.
This does NOT change the hitbox's knockback/launch angle!
*/
function hitbox_sprite_angle_set() {
	var _hitbox = argument[0];
	var _angle = argument[1];
	var _exact = argument_count > 2 ? argument[2] : false;
	with(_hitbox)
		{
		if (_exact)
			{
			image_angle = _angle;
			}
		else
			{
			image_angle = owner.facing == 1 ? _angle : -_angle;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */