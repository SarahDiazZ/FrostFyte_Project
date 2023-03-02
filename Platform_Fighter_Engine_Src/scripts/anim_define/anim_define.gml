///@category Animations
///@param {asset} sprite			The sprite to be used in the animation
///@param {array} [finish_anim]		The animation to switch to after the defined animation is finished
/*
Creates a new animation array with the given sprite and the normal animation values.
You can optionally attach a finish animation to the new animation, which will be played once the animation is finished.
*/
function anim_define() {
	var _new = [];
	_new[@ ANIMATION._FLAG_] =	-1;
	_new[@ ANIMATION.sprite] =	argument[0];
	_new[@ ANIMATION.frame] =	anim_frame_normal;
	_new[@ ANIMATION.speed] =	anim_speed_normal;
	_new[@ ANIMATION.scale] =	anim_scale_normal;
	_new[@ ANIMATION.angle] =	anim_angle_normal;
	_new[@ ANIMATION.alpha] =	anim_alpha_normal;
	_new[@ ANIMATION.offsetx] =	anim_offset_normal;
	_new[@ ANIMATION.offsety] =	anim_offset_normal;
	_new[@ ANIMATION.loop] =	argument_count > 1 ? false : true;
	_new[@ ANIMATION.finish] =	argument_count > 1 ? argument[1] : anim_finish_normal;
	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */