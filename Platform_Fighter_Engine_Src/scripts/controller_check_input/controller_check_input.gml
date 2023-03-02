///@category Inputs
///@param {int} device			The device port to check
///@param {int} button			The button to check, from the CONTROLLER enum
///@param {bool} pressed		Whether to count only pressed inputs or held inputs
/*
Returns true if the given button has been pressed on the given controller.
The CONTROLLER enum uses the Xbox controller layout.
*/
function controller_check_input() {
	var _c = argument[0];
	var _b = argument[1];
	var _p = argument[2];

	if (_p)
		{
		switch(_b)
			{
			case CONTROLLER.A: return gamepad_button_check_pressed(_c, gp_face1);
			case CONTROLLER.B: return gamepad_button_check_pressed(_c, gp_face2);
			case CONTROLLER.X: return gamepad_button_check_pressed(_c, gp_face3);
			case CONTROLLER.Y: return gamepad_button_check_pressed(_c, gp_face4);
			case CONTROLLER.LB: return gamepad_button_check_pressed(_c, gp_shoulderl);
			case CONTROLLER.LT: return gamepad_button_check_pressed(_c, gp_shoulderlb);
			case CONTROLLER.RB: return gamepad_button_check_pressed(_c, gp_shoulderr);
			case CONTROLLER.RT: return gamepad_button_check_pressed(_c, gp_shoulderrb);
			case CONTROLLER.START: return gamepad_button_check_pressed(_c, gp_start);
			case CONTROLLER.SELECT: return gamepad_button_check_pressed(_c, gp_select);
			case CONTROLLER.DPAD_U: return gamepad_button_check_pressed(_c, gp_padu);
			case CONTROLLER.DPAD_D: return gamepad_button_check_pressed(_c, gp_padd);
			case CONTROLLER.DPAD_R: return gamepad_button_check_pressed(_c, gp_padr);
			case CONTROLLER.DPAD_L: return gamepad_button_check_pressed(_c, gp_padl);
			default: crash("[controller_check_input] Invalid button (", _b, ")"); break;
			}
		}
	else
		{
		switch(_b)
			{
			case CONTROLLER.A: return gamepad_button_check(_c, gp_face1);
			case CONTROLLER.B: return gamepad_button_check(_c, gp_face2);
			case CONTROLLER.X: return gamepad_button_check(_c, gp_face3);
			case CONTROLLER.Y: return gamepad_button_check(_c, gp_face4);
			case CONTROLLER.LB: return gamepad_button_check(_c, gp_shoulderl);
			case CONTROLLER.LT: return gamepad_button_check(_c, gp_shoulderlb);
			case CONTROLLER.RB: return gamepad_button_check(_c, gp_shoulderr);
			case CONTROLLER.RT: return gamepad_button_check(_c, gp_shoulderrb);
			case CONTROLLER.START: return gamepad_button_check(_c, gp_start);
			case CONTROLLER.SELECT: return gamepad_button_check(_c, gp_select);
			case CONTROLLER.DPAD_U: return gamepad_button_check(_c, gp_padu);
			case CONTROLLER.DPAD_D: return gamepad_button_check(_c, gp_padd);
			case CONTROLLER.DPAD_R: return gamepad_button_check(_c, gp_padr);
			case CONTROLLER.DPAD_L: return gamepad_button_check(_c, gp_padl);
			default: crash("[controller_check_input] Invalid button (", _b, ")"); break;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */