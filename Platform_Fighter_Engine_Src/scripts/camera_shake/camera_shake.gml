///@category FX
///@param {real} h			The maximum horizontal shake
///@param {real} [v]		The maximum vertical shake
/*
Causes the game's camera to shake.
The values will be rounded if they are not already integers.
If only the first argument is given, the camera will use the horizontal shake value for the vertical shake.
*/
function camera_shake() {
	with(obj_game)
		{
		cam_shake_h = max(cam_shake_h, round(argument[0]));
		cam_shake_v = max(cam_shake_v, round(argument_count > 1 ? argument[1] : argument[0]));
		}
}
/* Copyright 2023 Springroll Games / Yosi */