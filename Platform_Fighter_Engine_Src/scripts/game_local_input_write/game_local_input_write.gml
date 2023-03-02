///@category Gameplay
///@param {buffer} buffer					The buffer to write the input data to
///@param {int} device_number				The device number
///@param {int} device_type					The device type, from the DEVICE enum
///@param {array} custom_controls			The custom controls array
///@param {int} flag						The input flag storing existing inputs
/*
A helper function that gets the input of a local player and writes it to the given buffer.
This is only intended to be used in <game_local_input> and <game_local_input_online>.
*/
function game_local_input_write() {
	var _b = argument[0];
	var _d = argument[1];
	var _dt = argument[2];
	var _cc = argument[3];
	var _flag = argument[4];
	var _lx = 0;
	var _ly = 0;
	var _rx = 0;
	var _ry = 0;
	
	#region Keyboard
	if (_dt == DEVICE.keyboard)
		{
		//Loop through the set keys and check what has been inputted
		for(var m = 0; m < array_length(_cc); m += 2)
			{
			var _key = _cc[@ m];
			var _input = _cc[@ m + 1];
			//Convert keyboard input to standard input
			if (_input < INPUT.LENGTH)
				{
				//Pressed
				if (keyboard_check_pressed(_key)) then _flag = bitflag_write(_flag, _input);
				//Held
				if (keyboard_check(_key)) then _flag = bitflag_write(_flag, _input + INPUT.LENGTH);
				}
			else
				{
				switch(_input)
					{
					case CC_INPUT_KEYBOARD.LU:
						if (keyboard_check(_key)) then _ly += -1;
						break;
					case CC_INPUT_KEYBOARD.LD:
						if (keyboard_check(_key)) then _ly += 1;
						break;
					case CC_INPUT_KEYBOARD.LR:
						if (keyboard_check(_key)) then _lx += 1;
						break;
					case CC_INPUT_KEYBOARD.LL:
						if (keyboard_check(_key)) then _lx += -1;
						break;
					case CC_INPUT_KEYBOARD.RU:
						if (keyboard_check(_key)) then _ry += -1;
						break;
					case CC_INPUT_KEYBOARD.RD:
						if (keyboard_check(_key)) then _ry += 1;
						break;
					case CC_INPUT_KEYBOARD.RR:
						if (keyboard_check(_key)) then _rx += 1;
						break;
					case CC_INPUT_KEYBOARD.RL:
						if (keyboard_check(_key)) then _rx += -1;
						break;
					case CC_INPUT_KEYBOARD.short_hop:
						if (keyboard_check_pressed(_key)) then _flag = bitflag_write(_flag, INPUT.jump);
						break;
					default: crash("[game_local_input_write] Invalid keyboard input (", _input, ")");
					}
				}
			}
		
		//Make sure control stick inputs are valid
		_lx = sign(_lx);
		_ly = sign(_ly);
		_rx = sign(_rx);
		_ry = sign(_ry);
		}
	#endregion 
	#region Controller
	else if (_dt == DEVICE.controller)
		{
		//Control sticks
		_lx = gamepad_axis_value(_d, gp_axislh);
		_ly = gamepad_axis_value(_d, gp_axislv);
		_rx = gamepad_axis_value(_d, gp_axisrh);
		_ry = gamepad_axis_value(_d, gp_axisrv);
		
		//Loop through the set controls and check what has been inputted
		for(var m = 0; m < array_length(_cc); m += 2)
			{
			var _control = _cc[@ m];
			var _input = _cc[@ m + 1];
			//Convert controller input to standard input
			if (_input < INPUT.LENGTH)
				{
				//Pressed
				if (controller_check_input(_d, _control, true)) then _flag = bitflag_write(_flag, _input);
				//Hold
				if (controller_check_input(_d, _control, false)) then _flag = bitflag_write(_flag, _input + INPUT.LENGTH);
				}
			else
				{
				switch(_input)
					{
					case CC_INPUT_CONTROLLER.LU:
						if (controller_check_input(_d, _control, false)) then _ly = -1;
						break;
					case CC_INPUT_CONTROLLER.LD:
						if (controller_check_input(_d, _control, false)) then _ly = 1;
						break;
					case CC_INPUT_CONTROLLER.LR:
						if (controller_check_input(_d, _control, false)) then _lx = 1;
						break;
					case CC_INPUT_CONTROLLER.LL:
						if (controller_check_input(_d, _control, false)) then _lx = -1;
						break;
					case CC_INPUT_CONTROLLER.RU:
						if (controller_check_input(_d, _control, false)) then _ry = -1;
						break;
					case CC_INPUT_CONTROLLER.RD:
						if (controller_check_input(_d, _control, false)) then _ry = 1;
						break;
					case CC_INPUT_CONTROLLER.RR:
						if (controller_check_input(_d, _control, false)) then _rx = 1;
						break;
					case CC_INPUT_CONTROLLER.RL:
						if (controller_check_input(_d, _control, false)) then _rx = -1;
						break;
					case CC_INPUT_CONTROLLER.short_hop:
						if (controller_check_input(_d, _control, true)) then _flag = bitflag_write(_flag, INPUT.jump);
						break;
					}
				}
			}
		}
	#endregion
	#region Touch
	else if (_dt == DEVICE.touch)
		{
		//There can only be 1 set of touch control objects
		
		//Control sticks
		_lx = obj_touch_stick.stick_x;
		_ly = obj_touch_stick.stick_y;
		_rx = 0; //No right stick
		_ry = 0; //No right stick
		
		//Pause input - This is always the button numbered -1!
		with(obj_touch_button)
			{
			if (number == -1)
				{
				//Pressed
				if (pressed) then _flag = bitflag_write(_flag, INPUT.pause);
				//Held
				if (held_time > 0) then _flag = bitflag_write(_flag, INPUT.pause + INPUT.LENGTH);
				break;
				}
			}
		
		//Loop through the set buttons and check what has been inputted
		for(var m = 0; m < array_length(_cc); m += 2)
			{
			var _button = _cc[@ m];
			var _input = _cc[@ m + 1];
			
			//Find the correct button
			with(obj_touch_button)
				{
				if (number == _button && number != -1)
					{
					//Convert touch  input to standard input
					if (_input < INPUT.LENGTH)
						{
						//Pressed
						if (pressed) then _flag = bitflag_write(_flag, _input);
						//Held
						if (held_time > 0) then _flag = bitflag_write(_flag, _input + INPUT.LENGTH);
						}
					else
						{
						switch(_input)
							{
							case CC_INPUT_TOUCH.LU:
								if (held_time > 0) then _ly += -1;
								break;
							case CC_INPUT_TOUCH.LD:
								if (held_time > 0) then _ly += 1;
								break;
							case CC_INPUT_TOUCH.LR:
								if (held_time > 0) then _lx += 1;
								break;
							case CC_INPUT_TOUCH.LL:
								if (held_time > 0) then _lx += -1;
								break;
							case CC_INPUT_TOUCH.RU:
								if (held_time > 0) then _ry += -1;
								break;
							case CC_INPUT_TOUCH.RD:
								if (held_time > 0) then _ry += 1;
								break;
							case CC_INPUT_TOUCH.RR:
								if (held_time > 0) then _rx += 1;
								break;
							case CC_INPUT_TOUCH.RL:
								if (held_time > 0) then _rx += -1;
								break;
							case CC_INPUT_TOUCH.short_hop:
								if (pressed) then _flag = bitflag_write(_flag, INPUT.jump);
								break;
							default: crash("[game_local_input_write] Invalid touch input (", _input, ")");
							}
						}
					break;
					}
				}
			}
		
		//Make sure control stick inputs are valid
		_lx = clamp(_lx, -1, 1);
		_ly = clamp(_ly, -1, 1);
		_rx = clamp(_rx, -1, 1);
		_ry = clamp(_ry, -1, 1);
		}
	#endregion
	else crash("[game_local_input_write] Invalid device type (", _dt, ")");
	
	//Write to the buffer
	buffer_write(_b, buffer_u32, _flag);
	
	buffer_write(_b, buffer_s8, round(_lx * 100.0));
	buffer_write(_b, buffer_s8, round(_ly * 100.0));
	buffer_write(_b, buffer_s8, round(_rx * 100.0));
	buffer_write(_b, buffer_s8, round(_ry * 100.0));
}
/* Copyright 2023 Springroll Games / Yosi */