///@category Animations
///@param {asset} sprite			The sprite to use
///@param {int}	length				The number of frames you want the animation to take
/*
Calculates what speed would be needed for the given sprite to finish in the specified number of frames.
*/
function anim_calculate_speed() {
	var _sprite = argument[0];
	var _frames = (argument[1] + 1);
	var _subimages = sprite_get_number(_sprite);
	
	return ((_subimages / _frames));
}
/* Copyright 2023 Springroll Games / Yosi */