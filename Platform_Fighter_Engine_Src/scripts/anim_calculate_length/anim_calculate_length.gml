///@category Animations
///@param {asset} sprite			The sprite to use
///@param {int}	speed				The speed of the animation
/*
Calculates how many frames the given sprite will take to finish when running at the specified speed.
*/
function anim_calculate_length() {
	var _sprite = argument[0];
	var _speed = argument[1];
	var _subimages = sprite_get_number(_sprite);
	
	var _rounded = floor(_subimages / _speed);
	return (_rounded == _subimages / _speed) ? (_rounded - 1) : _rounded;
}
/* Copyright 2023 Springroll Games / Yosi */