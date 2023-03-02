///@category Custom Controls
///@param {struct} custom_controls		The custom controls struct to set to the defaults
/*
Sets a custom controls struct to the "default" custom controls.
*/
function custom_controls_default() {
	var _struct = argument[0];
	var _inputs = undefined;
	
	//Controller
	_inputs = _struct.inputs_controller;

	_inputs[@ CC_INPUT_CONTROLLER.attack] =		[CONTROLLER.B];
	_inputs[@ CC_INPUT_CONTROLLER.special] =	[CONTROLLER.A];
	_inputs[@ CC_INPUT_CONTROLLER.jump] =		[CONTROLLER.X, CONTROLLER.Y];
	_inputs[@ CC_INPUT_CONTROLLER.grab] =		[CONTROLLER.LB, CONTROLLER.LT];
	_inputs[@ CC_INPUT_CONTROLLER.shield] =		[CONTROLLER.RB, CONTROLLER.RT];
	_inputs[@ CC_INPUT_CONTROLLER.pause] =		[CONTROLLER.START];
	_inputs[@ CC_INPUT_CONTROLLER.smash] =		[];
	_inputs[@ CC_INPUT_CONTROLLER.taunt] =		[CONTROLLER.DPAD_D];
	_inputs[@ CC_INPUT_CONTROLLER.short_hop] =	[];
	_inputs[@ CC_INPUT_CONTROLLER.run] =		[];
	_inputs[@ CC_INPUT_CONTROLLER.LR] =			[];
	_inputs[@ CC_INPUT_CONTROLLER.LL] =			[];
	_inputs[@ CC_INPUT_CONTROLLER.LU] =			[];
	_inputs[@ CC_INPUT_CONTROLLER.LD] =			[];
	_inputs[@ CC_INPUT_CONTROLLER.RR] =			[];
	_inputs[@ CC_INPUT_CONTROLLER.RL] =			[];
	_inputs[@ CC_INPUT_CONTROLLER.RU] =			[];
	_inputs[@ CC_INPUT_CONTROLLER.RD] =			[];

	//Keyboard
	_inputs = _struct.inputs_keyboard;

	_inputs[@ CC_INPUT_KEYBOARD.attack] =		[ord("P")];
	_inputs[@ CC_INPUT_KEYBOARD.special] =		[ord("O")];
	_inputs[@ CC_INPUT_KEYBOARD.jump] =			[ord("W"), vk_space];
	_inputs[@ CC_INPUT_KEYBOARD.grab] =			[ord("U")];
	_inputs[@ CC_INPUT_KEYBOARD.shield] =		[ord("I")];
	_inputs[@ CC_INPUT_KEYBOARD.pause] =		[vk_enter];
	_inputs[@ CC_INPUT_KEYBOARD.smash] =		[ord("Y")];
	_inputs[@ CC_INPUT_KEYBOARD.taunt] =		[ord("1")];
	_inputs[@ CC_INPUT_KEYBOARD.short_hop] =	[];
	_inputs[@ CC_INPUT_KEYBOARD.run] =			[vk_shift];
	_inputs[@ CC_INPUT_KEYBOARD.LR] =			[ord("D")];
	_inputs[@ CC_INPUT_KEYBOARD.LL] =			[ord("A")];
	_inputs[@ CC_INPUT_KEYBOARD.LU] =			[ord("W")];
	_inputs[@ CC_INPUT_KEYBOARD.LD] =			[ord("S")];
	_inputs[@ CC_INPUT_KEYBOARD.RR] =			[];
	_inputs[@ CC_INPUT_KEYBOARD.RL] =			[];
	_inputs[@ CC_INPUT_KEYBOARD.RU] =			[];
	_inputs[@ CC_INPUT_KEYBOARD.RD] =			[];
	
	//Touch
	_inputs = _struct.inputs_touch;
	
	_inputs[@ CC_INPUT_TOUCH.attack] =			[1];
	_inputs[@ CC_INPUT_TOUCH.special] =			[2];
	_inputs[@ CC_INPUT_TOUCH.jump] =			[3];
	_inputs[@ CC_INPUT_TOUCH.grab] =			[5];
	_inputs[@ CC_INPUT_TOUCH.shield] =			[4];
	_inputs[@ CC_INPUT_TOUCH.pause] =			[-1];
	_inputs[@ CC_INPUT_TOUCH.smash] =			[6];
	_inputs[@ CC_INPUT_TOUCH.taunt] =			[];
	_inputs[@ CC_INPUT_TOUCH.short_hop] =		[];
	_inputs[@ CC_INPUT_TOUCH.run] =				[];
	_inputs[@ CC_INPUT_TOUCH.LR] =				[];
	_inputs[@ CC_INPUT_TOUCH.LL] =				[];
	_inputs[@ CC_INPUT_TOUCH.LU] =				[];
	_inputs[@ CC_INPUT_TOUCH.LD] =				[];
	_inputs[@ CC_INPUT_TOUCH.RR] =				[];
	_inputs[@ CC_INPUT_TOUCH.RL] =				[];
	_inputs[@ CC_INPUT_TOUCH.RU] =				[];
	_inputs[@ CC_INPUT_TOUCH.RD] =				[];
	
	//Right stick input
	_struct.right_stick_input = INPUT.smash;

	//SCS
	_struct.scs = array_create(SCS.LENGTH, false);
		
	//ACS
	var _acs = _struct.acs;
	_acs[@ ACS.maximum_l] = 1.0;
	_acs[@ ACS.speed_l] = 1.0;
	_acs[@ ACS.deadzone_l] = 0.0;
	_acs[@ ACS.rotate_l] = false;
	_acs[@ ACS.invert_x_l] = false;
	_acs[@ ACS.invert_y_l] = false;
	
	_acs[@ ACS.maximum_r] = 1.0;
	_acs[@ ACS.speed_r] = 1.0;
	_acs[@ ACS.deadzone_r] = 0.0;
	_acs[@ ACS.rotate_r] = false;
	_acs[@ ACS.invert_x_r] = false;
	_acs[@ ACS.invert_y_r] = false;
}
/* Copyright 2023 Springroll Games / Yosi */