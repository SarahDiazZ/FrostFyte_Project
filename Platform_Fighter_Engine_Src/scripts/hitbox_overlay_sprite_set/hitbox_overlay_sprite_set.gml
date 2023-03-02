///@category Hitboxes
///@param {id} hitbox			The hitbox to change the overlay sprite for
///@param {asset} sprite		The sprite
///@param {int} frame			The frame of the sprite to start on
///@param {real} speed			The speed at which the sprite should animate
///@param {real} scale			The scale of the sprite
///@param {real} angle			The angle of the sprite
///@param {color} color			The color blend of the sprite
///@param {real} alpha			The transparency of the sprite, from 0 to 1
///@param {int} facing			The direction the sprite is facing (-1 or 1)
///@desc Sets the overlay sprite properties for a hitbox
/*
Please note: This function is mainly intended for <obj_hitbox_projectile>, as it is the only hitbox type that uses a palette shader.
*/
function hitbox_overlay_sprite_set() {
	with(argument[0])
		{
		overlay_sprite = argument[1];
		overlay_frame  = argument[2];
		overlay_speed  = argument[3];
		overlay_scale  = argument[4];
		overlay_angle  = argument[5];
		overlay_color  = argument[6];
		overlay_alpha  = argument[7];
		overlay_facing = argument[8];
		}
}
/* Copyright 2023 Springroll Games / Yosi */