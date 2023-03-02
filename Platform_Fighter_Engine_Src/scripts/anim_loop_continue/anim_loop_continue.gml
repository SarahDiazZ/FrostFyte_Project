///@category Animations
///@param {array/asset} anim		The animation array or sprite to assign to the player
/*
Sets the current animation for the calling player to be the given animation or sprite.
If the player already has the given animation, then the frame number is not reset, allowing the animation to continue looping.
*/
function anim_loop_continue() {
	if (is_array(argument[0]))
		{
		var _a = argument[0];
		if (anim_equals(_a)) then return false;
	
		anim_current =	_a;
		anim_sprite =	_a[@ ANIMATION.sprite];
		anim_frame =	_a[@ ANIMATION.frame];
		anim_speed =	_a[@ ANIMATION.speed];
		anim_scale =	_a[@ ANIMATION.scale];
		anim_angle =	_a[@ ANIMATION.angle];
		anim_alpha =	_a[@ ANIMATION.alpha];
		anim_offsetx =	_a[@ ANIMATION.offsetx];
		anim_offsety =	_a[@ ANIMATION.offsety];
		anim_loop =		_a[@ ANIMATION.loop];
		anim_finish =	_a[@ ANIMATION.finish];
		return true;
		}
	else if (sprite_exists(argument[0]))
		{
		//Sprite
		anim_current = -1;
		anim_sprite = argument[0];

		//Don't set the Frame
	
		//Speed
		anim_speed = anim_speed_normal;

		//Scale
		anim_scale = anim_scale_normal;
	
		//Angle
		anim_angle = anim_angle_normal;
	
		//Alpha
		anim_alpha = anim_alpha_normal;
	
		//Offset X
		anim_offsetx = anim_offset_normal;
	
		//Offset Y
		anim_offsety = anim_offset_normal;
	
		//Loop
		anim_loop = anim_loop_normal;
	
		//Finish Animation
		anim_finish = anim_finish_normal;
		
		return true;
		}
}
/* Copyright 2023 Springroll Games / Yosi */