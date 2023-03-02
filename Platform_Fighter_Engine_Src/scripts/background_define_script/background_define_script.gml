///@category Backgrounds
///@param {asset} sprite			The sprite for the background to use
///@param {real} xoff				The horizontal offset of the background
///@param {real} yoff				The vertical offset of the background
///@param {real} scale				The scale of the background
///@param {real} move_x				The horizontal parallax multiplier
///@param {real} move_y				The vertical parallax multiplier
///@param {real} xspd				How fast the background moves horizontally
///@param {real} yspd				How fast the background moves vertically
///@param {bool} absolute			If the background is drawn from (0, 0), or drawn from the camera center
///@param {real} img_speed			The animation speed of the background
///@param {asset} script			The script for the background to use when being drawn
/*
Creates a new array that stores information for <obj_stage_manager> to use when drawing background layers.
If the optional argument "absolute" is set to true, the background is drawn from (0, 0) in the room.
Otherwise, the argument is drawn at the center of the camera.
Please note: Any backgrounds with a nonzero "xspd" or "yspd" should have "absolute" set to true and should have their sprite origin on the left so they wrap the screen properly.
The given script will be run by <obj_stage_manager> in place of the background being drawn normally.
The script is automatically passed the following arguments:
	- layer : Which "layer" (index in the background array) the background is on
	- draw_x : The x coordinate the background would be drawn at
	- draw_y : The y coordinate the background would be drawn at
	- cam_dist_x : The horizontal distance the camera has moved from the center
	- cam_dist_y : The vertical distance the camera has moved from the center
*/
function background_define_script() {
	var _new = array_create(BACK.length);

	_new[BACK.sprite] = argument[0];
	_new[BACK.x] = argument[1];
	_new[BACK.y] = argument[2];
	_new[BACK.scale] = argument[3];
	_new[BACK.parallax_x] = argument[4];
	_new[BACK.parallax_y] = argument[5];
	_new[BACK.xspd] = argument[6];
	_new[BACK.yspd] = argument[7];
	_new[BACK.absolute] = argument[8];
	_new[BACK.imgspeed] = argument[9];
	_new[BACK.frame] = 0;
	_new[BACK.script] = argument[10];

	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */