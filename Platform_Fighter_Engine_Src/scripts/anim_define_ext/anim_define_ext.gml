///@category Animations
///@param {asset} sprite			The sprite to be used in the animation
///@param {real} [frame]			The subimage of the sprite to start on
///@param {real} [speed]			The speed at which the sprite cycles through the subimages per frame
///@param {real} [scale]			The scale of the sprite
///@param {real} [angle]			The angle of the sprite in degrees
///@param {real} [alpha]			The transparency of the animation. Must be from 0 to 1
///@param {real} [offsetx]			The horizontal offset of the animation from the origin
///@param {real} [offsety]			The vertical offset of the animation from the origin
///@param {bool} [loop]				Whether the animation loops or not
///@param {array} [finish_anim]		The animation to switch to after the defined animation is finished
/*
Creates a new animation array with the given properties.
The default values for arguments will use the following macros:
	- <anim_frame_normal>
	- <anim_speed_normal>
	- <anim_scale_normal>
	- <anim_angle_normal>
	- <anim_alpha_normal>
	- <anim_offset_normal>
	- <anim_loop_normal>
	- <anim_finish_normal>
*/
function anim_define_ext() {
	var _new = [];
	_new[@ ANIMATION._FLAG_] =	-1;
	_new[@ ANIMATION.sprite] =	argument[0];
	_new[@ ANIMATION.frame] =	argument_count > 1 ? argument[1] : anim_frame_normal;
	_new[@ ANIMATION.speed] =	argument_count > 2 ? argument[2] : anim_speed_normal;
	_new[@ ANIMATION.scale] =	argument_count > 3 ? argument[3] : anim_scale_normal;
	_new[@ ANIMATION.angle] =	argument_count > 4 ? argument[4] : anim_angle_normal;
	_new[@ ANIMATION.alpha] =	argument_count > 5 ? argument[5] : anim_alpha_normal;
	_new[@ ANIMATION.offsetx] =	argument_count > 6 ? argument[6] : anim_offset_normal;
	_new[@ ANIMATION.offsety] =	argument_count > 7 ? argument[7] : anim_offset_normal;
	_new[@ ANIMATION.loop] =	argument_count > 8 ? argument[8] : anim_loop_normal;
	_new[@ ANIMATION.finish] =	argument_count > 9 ? argument[9] : anim_finish_normal;
	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */