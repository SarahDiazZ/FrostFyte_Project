///@category Hurtboxes
///@param {asset} sprite		The sprite to change the player's hurtbox to
///@param {int} frame			The frame of the sprite to use
///@param {real} xscale			The horizontal scaling
///@param {real} yscale			The vertical scaling
///@param {real} angle			The angle
/*
Changes the sprite of the permanent hurtbox of the calling player to have the given properties.
*/
function hurtbox_anim_set() {
	if (sprite_exists(argument[0]))
		{
		hurtbox.sprite_index = argument[0];
		hurtbox.image_index = argument[1];
		hurtbox.image_xscale = argument[2];
		hurtbox.image_yscale = argument[3];
		hurtbox.image_angle = argument[4];
		}
}
/* Copyright 2023 Springroll Games / Yosi */