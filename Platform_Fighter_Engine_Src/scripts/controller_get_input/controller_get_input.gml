///@category Inputs
///@param {int} device		The device port to check
///@desc Returns an array of current inputs from a device.
/*
Returns an array of the current buttons being pressed on the given controller, represented by the CONTROLLER enum.
The CONTROLLER enum uses the Xbox controller layout.
*/
function controller_get_input() {
	var _c = argument[0];
	var _a = [];

	if (gamepad_button_check(_c, gp_face1)) then array_push(_a, CONTROLLER.A);
	if (gamepad_button_check(_c, gp_face2)) then array_push(_a, CONTROLLER.B);
	if (gamepad_button_check(_c, gp_face3)) then array_push(_a, CONTROLLER.X);
	if (gamepad_button_check(_c, gp_face4)) then array_push(_a, CONTROLLER.Y);
	if (gamepad_button_check(_c, gp_shoulderr)) then array_push(_a, CONTROLLER.RB);
	if (gamepad_button_check(_c, gp_shoulderl)) then array_push(_a, CONTROLLER.LB);
	if (gamepad_button_check(_c, gp_shoulderrb)) then array_push(_a, CONTROLLER.RT);
	if (gamepad_button_check(_c, gp_shoulderlb)) then array_push(_a, CONTROLLER.LT);
	if (gamepad_button_check(_c, gp_start)) then array_push(_a, CONTROLLER.START);
	if (gamepad_button_check(_c, gp_select)) then array_push(_a, CONTROLLER.SELECT);
	if (gamepad_button_check(_c, gp_padu)) then array_push(_a, CONTROLLER.DPAD_U);
	if (gamepad_button_check(_c, gp_padd)) then array_push(_a, CONTROLLER.DPAD_D);
	if (gamepad_button_check(_c, gp_padr)) then array_push(_a, CONTROLLER.DPAD_R);
	if (gamepad_button_check(_c, gp_padl)) then array_push(_a, CONTROLLER.DPAD_L);
	
	return _a;
}
/* Copyright 2023 Springroll Games / Yosi */