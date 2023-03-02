///@param {real} y			The y value in the room to translate to the screen
/*
Returns where the given y value in the room would be on the screen after the camera is applied.
Warning: An instance of <obj_game> must be in the room for this function to work.
*/
function screen_y() {
	var _v = argument[0];
	return (_v - obj_game.cam_y) * (screen_height / obj_game.cam_h);
}
/* Copyright 2023 Springroll Games / Yosi */