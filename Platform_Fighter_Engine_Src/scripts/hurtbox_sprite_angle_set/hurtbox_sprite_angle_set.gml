///@category Hurtboxes
///@param {id} hurtbox		The hurtbox to change the sprite angle of
///@param {real} angle		The angle, assuming the hurtbox is facing right
/*
Sets the angle of the given hurtbox.
*/
function hurtbox_sprite_angle_set() {
	with(argument[0])
		{
		image_angle = owner.facing == 1 ? argument[1] : -argument[1];
		}
}
/* Copyright 2023 Springroll Games / Yosi */