///@category Animations
///@param {array/asset} anim		The animation array or sprite to compare with the player's current animation
/*
Returns true if the player's current animation or sprite is equal to the given animation or sprite
*/
function anim_equals() {
	var _a = argument[0];
	
	//Animation check
	if (is_array(anim_current) && is_array(_a) && array_equals(anim_current, _a))
		{
		return true;
		}
		
	//Sprite check
	if (anim_sprite == _a)
		{
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */