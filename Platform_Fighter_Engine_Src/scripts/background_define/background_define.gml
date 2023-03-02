///@category Backgrounds
///@param {asset} sprite			The sprite for the background to use
///@param {real} xoff				The horizontal offset of the background
///@param {real} yoff				The vertical offset of the background
///@param {real} scale				The scale of the background
///@param {real} move_x				The horizontal parallax multiplier
///@param {real} move_y				The vertical parallax multiplier
///@param {real} [xspd]				How fast the background moves horizontally
///@param {real} [yspd]				How fast the background moves vertically
///@param {bool} [absolute]			If the background is drawn from (0, 0), or drawn from the camera center
///@param {real} [img_speed]		The animation speed of the background
/*
Creates a new array that stores information for <obj_stage_manager> to use when drawing background layers.
If the optional argument "absolute" is set to true, the background is drawn from (0, 0) in the room.
Otherwise, the argument is drawn at the center of the camera.
Please note: Any backgrounds with a nonzero "xspd" or "yspd" should have "absolute" set to true and should have their sprite origin on the left so they wrap the screen properly.
*/
function background_define() {
	var _new = array_create(BACK.length);

	_new[@ BACK.sprite] = argument[0];
	_new[@ BACK.x] = argument[1];
	_new[@ BACK.y] = argument[2];
	_new[@ BACK.scale] = argument[3];
	_new[@ BACK.parallax_x] = argument[4];
	_new[@ BACK.parallax_y] = argument[5];
	_new[@ BACK.xspd] = argument_count > 6 ? argument[6] : 0;
	_new[@ BACK.yspd] = argument_count > 7 ? argument[7] : 0;
	_new[@ BACK.absolute] = argument_count > 8 ? argument[8] : false;
	_new[@ BACK.imgspeed] = argument_count > 9 ? argument[9] : 0;
	_new[@ BACK.frame] = 0;
	_new[@ BACK.script] = -1;

	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */