///@param {int} button		The gp_* constant
/*
This function takes one of the built-in "gp_*" constants and returns a number for it, corresponding to the correct frame in "spr_icon_input_button_univeral".
It is intended for use in menus and UI code.
	gp_face1 = 0
	gp_face2 = 1
	gp_face3 = 2
	gp_face4 = 3
	gp_shoulderl = 4
	gp_shoulderr = 5
	gp_shoulderlb = 6
	gp_shoulderrb = 7
	gp_start = 8
	gp_select = 9
	gp_padu = 10
	gp_padd = 11
	gp_padr = 12
	gp_padl = 13
	gp_stickl = 14
	gp_stickr = 15
*/
function gamepad_button_number() {
	var _b = argument[0];
	if (is_array(_b)) then _b = _b[@ 0];
	if (_b == gp_face1) then return 0;
	if (_b == gp_face2) then return 1;
	if (_b == gp_face3) then return 2;
	if (_b == gp_face4) then return 3;
	if (_b == gp_shoulderl) then return 4;
	if (_b == gp_shoulderr) then return 5;
	if (_b == gp_shoulderlb) then return 6;
	if (_b == gp_shoulderrb) then return 7;
	if (_b == gp_start) then return 8;
	if (_b == gp_select) then return 9;
	if (_b == gp_padu) then return 10;
	if (_b == gp_padd) then return 11;
	if (_b == gp_padr) then return 12;
	if (_b == gp_padl) then return 13;
	if (_b == gp_stickl) then return 14;
	if (_b == gp_stickr) then return 15;
	crash("[gamepad_button_number] The argument passed was not a gp_* constant");
}
/* Copyright 2023 Springroll Games / Yosi */