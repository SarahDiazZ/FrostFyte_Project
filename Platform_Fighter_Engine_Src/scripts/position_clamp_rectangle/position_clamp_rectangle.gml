///@param {real} x			The x position
///@param {real} y			The y position
///@param {real} pad		The amount the rectangle will be shrunken from each side
///@param {real} left		The left coordinate of the rectangle
///@param {real} top		The top coordinate of the rectangle
///@param {real} width		The width of the rectangle
///@param {real} height		The height of the rectangle
/*
Returns a struct with the x and y positions clamped inside the given rectangle.
*/
function position_clamp_rectangle() {

	var _new_x = argument[0],
		_new_y = argument[1],
		_pad = argument[2],
		_vx = argument[3],
		_vy = argument[4],
		_vw = argument[5],
		_vh = argument[6];
	
	_new_x = clamp(_new_x, _vx + _pad, _vx + _vw - _pad);
	_new_y = clamp(_new_y, _vy + _pad, _vy + _vh - _pad);

	return { x : _new_x, y : _new_y };
}
/* Copyright 2023 Springroll Games / Yosi */