///@param {real} x			The x value in the room to translate to the screen
/*
Returns where the given x value in the room would be on the screen after the camera is applied.
Warning: An instance of <obj_game> must be in the room for this function to work.
*/
function screen_x() {
	var _v = argument[0];
	return (_v - obj_game.cam_x) * (screen_width / obj_game.cam_w);
}
/* Copyright 2023 Springroll Games / Yosi */