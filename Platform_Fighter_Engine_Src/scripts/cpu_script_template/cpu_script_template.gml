///@category Inputs
///@param {real} lx		The x position of the left stick
///@param {real} ly		The y position of the left stick
///@param {real} rx		The x position of the right stick
///@param {real} ry		The y position of the right stick
/*
A template for character-specific CPU input scripts.
The script should accept arguments for the left and right stick coordinates, and return a struct with the same variables:
	"lx"
	"ly"
	"rx"
	"ry"
*/
function cpu_script_template() {
	var _lx = argument[0];
	var _ly = argument[1];
	var _rx = argument[2];
	var _ry = argument[3];
	
	/*
	Any CPU logic goes here.
	You can change the _lx, _ly, _rx, and _ry variables to change the stick coordinates.
	Use cpu_press, cpu_hold, and cpu_release to make the CPU press inputs.
	Use cpu_check_input to see if the default CPU script made the CPU press or hold a certain input already.
	*/
	
	//Return the changed stick coordinates
	return
		{
		lx : _lx,
		ly : _ly,
		rx : _rx,
		ry : _ry,
		};
}
/* Copyright 2023 Springroll Games / Yosi */