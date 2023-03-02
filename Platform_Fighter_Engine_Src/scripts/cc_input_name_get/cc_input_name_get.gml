///@category Custom Controls
///@param {int} device_type			The device type, from the DEVICE enum
///@param {int} input				The input, from either the CC_INPUT_CONTROLLER enum or the CC_INPUT_KEYBOARD enum
/*
Returns the name of the given custom controls input.
If you want to get the name of a normal input, use <input_name_get>.
*/
function cc_input_name_get() {
	var _device = argument[0];
	var _input = argument[1];
	if (_device == DEVICE.controller)
		{
		switch(_input)
			{
			case CC_INPUT_CONTROLLER.attack:	return "Attack";
			case CC_INPUT_CONTROLLER.grab:		return "Grab";
			case CC_INPUT_CONTROLLER.jump:		return "Jump";
			case CC_INPUT_CONTROLLER.pause:		return "Pause";
			case CC_INPUT_CONTROLLER.shield:	return "Shield";
			case CC_INPUT_CONTROLLER.smash:		return "Smash";
			case CC_INPUT_CONTROLLER.special:	return "Special";
			case CC_INPUT_CONTROLLER.taunt:		return "Taunt";
			case CC_INPUT_CONTROLLER.run:		return "Run";
			
			case CC_INPUT_CONTROLLER.short_hop:	return "Short Hop";
			case CC_INPUT_CONTROLLER.LR:		return "LR";
			case CC_INPUT_CONTROLLER.LL:		return "LL";
			case CC_INPUT_CONTROLLER.LU:		return "LU";
			case CC_INPUT_CONTROLLER.LD:		return "LD";
			case CC_INPUT_CONTROLLER.RR:		return "RR";
			case CC_INPUT_CONTROLLER.RL:		return "RL";
			case CC_INPUT_CONTROLLER.RU:		return "RU";
			case CC_INPUT_CONTROLLER.RD:		return "RD";
			default: crash("[cc_input_name_get] Invalid input (", _device, ")"); break;
			}
		}
	else if (_device == DEVICE.keyboard)
		{
		switch(_input)
			{
			case CC_INPUT_KEYBOARD.attack:		return "Attack";
			case CC_INPUT_KEYBOARD.grab:		return "Grab";
			case CC_INPUT_KEYBOARD.jump:		return "Jump";
			case CC_INPUT_KEYBOARD.pause:		return "Pause";
			case CC_INPUT_KEYBOARD.shield:		return "Shield";
			case CC_INPUT_KEYBOARD.smash:		return "Smash";
			case CC_INPUT_KEYBOARD.special:		return "Special";
			case CC_INPUT_KEYBOARD.taunt:		return "Taunt";
			case CC_INPUT_KEYBOARD.run:			return "Run";
			
			case CC_INPUT_KEYBOARD.short_hop:	return "Short Hop";	
			case CC_INPUT_KEYBOARD.LR:			return "LR";
			case CC_INPUT_KEYBOARD.LL:			return "LL";
			case CC_INPUT_KEYBOARD.LU:			return "LU";
			case CC_INPUT_KEYBOARD.LD:			return "LD";
			case CC_INPUT_KEYBOARD.RR:			return "RR";
			case CC_INPUT_KEYBOARD.RL:			return "RL";
			case CC_INPUT_KEYBOARD.RU:			return "RU";
			case CC_INPUT_KEYBOARD.RD:			return "RD";
			default: crash("[cc_input_name_get] Invalid input (", _device, ")"); break;
			}
		}
	else if (_device == DEVICE.touch)
		{
		switch(_input)
			{
			case CC_INPUT_TOUCH.attack:			return "Attack";
			case CC_INPUT_TOUCH.grab:			return "Grab";
			case CC_INPUT_TOUCH.jump:			return "Jump";
			case CC_INPUT_TOUCH.pause:			return "Pause";
			case CC_INPUT_TOUCH.shield:			return "Shield";
			case CC_INPUT_TOUCH.smash:			return "Smash";
			case CC_INPUT_TOUCH.special:		return "Special";
			case CC_INPUT_TOUCH.taunt:			return "Taunt";
			case CC_INPUT_TOUCH.run:			return "Run";
			
			case CC_INPUT_TOUCH.short_hop:		return "Short Hop";	
			case CC_INPUT_TOUCH.LR:				return "LR";
			case CC_INPUT_TOUCH.LL:				return "LL";
			case CC_INPUT_TOUCH.LU:				return "LU";
			case CC_INPUT_TOUCH.LD:				return "LD";
			case CC_INPUT_TOUCH.RR:				return "RR";
			case CC_INPUT_TOUCH.RL:				return "RL";
			case CC_INPUT_TOUCH.RU:				return "RU";
			case CC_INPUT_TOUCH.RD:				return "RD";
			default: crash("[cc_input_name_get] Invalid input (", _device, ")"); break;
			}
		}
	else
		{
		crash("[cc_input_name_get] Invalid device type (", _device, ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */