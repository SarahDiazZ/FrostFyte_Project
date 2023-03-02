///@category Inputs
///@param {int} paused_inputs_flag		The number used to store paused inputs
///@param {id} [id]						The id of the player to store paused inputs for
/*
Used during Frame Advance to store player's inputs while the game is paused.
This is essentially a smaller version of <game_local_input_write>.
*/
function input_paused_collect() {
	var _paused_inputs_flag = argument[0];
	var _p = argument_count > 1 ? argument[1] : id;
	var _flag = _paused_inputs_flag;
	
	//Device / Custom Control specifications
	var _cc = _p.custom_controls;
	var _d = _p.device;
	var _dt = _p.device_type;
	
	#region Keyboard
	if (_dt == DEVICE.keyboard)
		{
		//Loop through the set keys and check what has been inputted
		for(var m = 0; m < array_length(_cc); m += 2)
			{
			var _key = _cc[@ m];
			var _input = _cc[@ m + 1];
			//Don't register pause inputs
			if (_input == INPUT.pause) then continue;
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
				if (_input == CC_INPUT_KEYBOARD.short_hop)
					{
					if (keyboard_check_pressed(_key)) then _flag = bitflag_write(_flag, INPUT.jump);
					}
				}
			}
		}
	#endregion 
	#region Controller
	else if (_dt == DEVICE.controller)
		{
		//Loop through the set controls and check what has been inputted
		for(var m = 0; m < array_length(_cc); m += 2)
			{
			var _control = _cc[m];
			var _input = _cc[m + 1];
			//Don't register pause inputs
			if (_input == INPUT.pause) then continue;
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
				if (_input == CC_INPUT_CONTROLLER.short_hop)
					{
					if (controller_check_input(_d, _control, true)) then _flag = bitflag_write(_flag, INPUT.jump);
					}
				}
			}
		}
	#endregion
	#region Touch
	else if (_dt == DEVICE.touch)
		{
		//There can only be 1 set of touch control objects
		
		//Loop through the set buttons and check what has been inputted
		for(var m = 0; m < array_length(_cc); m += 2)
			{
			var _button = _cc[@ m];
			var _input = _cc[@ m + 1];
				
			//Find the correct button
			with(obj_touch_button)
				{
				if (number == _button)
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
		}
	#endregion
	#region None
	else if (_dt == DEVICE.none)
		{
		//No inputs
		//The CPU uses DEVICE.none, so it does not make any inputs when the game is paused.
		}
	#endregion
	else crash("[input_paused_collect] Invalid device type (", _dt, ")");
	
	//Set the paused inputs
	paused_inputs_flag = _flag;
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */