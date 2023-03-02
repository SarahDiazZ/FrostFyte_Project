///@description Update all device input

//Automatic connect (make sure it doesn't go over the max number of total devices!)
if (mis_data().auto_connect && array_length(mis_data().devices) < mis_data().max_total)
	{
	//Controllers
	var _num = mis_data().max_controllers;
	for(var i = 0; i < _num; i++)
		{
		if (gamepad_is_connected(i))
			{
			if (!mis_device_port_is_connected(i, MIS_DEVICE_TYPE.controller))
				{
				//Connect if a button is pressed or the stick is tilted
				var _buttons = mis_data().controller_inputs;
				var _connected = false;
				if (gamepad_button_check_pressed(i, gp_face1)			||
					gamepad_button_check_pressed(i, gp_face2)			||
					gamepad_button_check_pressed(i, gp_face3)			||
					gamepad_button_check_pressed(i, gp_face4)			||
					gamepad_button_check_pressed(i, gp_shoulderr)		||
					gamepad_button_check_pressed(i, gp_shoulderl)		||
					gamepad_button_check_pressed(i, gp_shoulderrb)		||
					gamepad_button_check_pressed(i, gp_shoulderlb)		||
					gamepad_button_check_pressed(i, gp_start)			||
					gamepad_button_check_pressed(i, gp_select)			||
					gamepad_button_check_pressed(i, gp_padr)			||
					gamepad_button_check_pressed(i, gp_padl)			||
					gamepad_button_check_pressed(i, gp_padd)			||
					gamepad_button_check_pressed(i, gp_padu))
					{
					mis_device_connect(MIS_DEVICE_TYPE.controller, i);
					_connected = true;
					}
				if (!_connected)
					{
					var _sx = gamepad_axis_value(i, gp_axislh);
					var _sy = gamepad_axis_value(i, gp_axislv);
					var _len = point_distance(0, 0, _sx, _sy);
					if (_len > mis_data().controller_deadzone)
						{
						mis_device_connect(MIS_DEVICE_TYPE.controller, i);
						_connected = true;
						}
					}
				}
			}
		}
	//Keyboards
	var _num = mis_data().max_keyboards;
	for(var i = 0; i < _num; i++)
		{
		if (!mis_device_port_is_connected(i, MIS_DEVICE_TYPE.keyboard))
			{
			//Connect if any key is pressed
			if (keyboard_check_pressed(vk_anykey))
				{
				mis_device_connect(MIS_DEVICE_TYPE.keyboard, i);
				}
			}
		}
	}

//Loop through all devices
var _array = mis_data().devices;
var _size = array_length(_array);
for(var i = 0; i < _size; i++)
	{
	var _device = _array[@ i];
	var _type = _device[@ MIS_DEVICE_PROPERTY.device_type];
	var _port = _device[@ MIS_DEVICE_PROPERTY.port_number];
	var _inputs = _device[@ MIS_DEVICE_PROPERTY.inputs];
	var _stick = _device[@ MIS_DEVICE_PROPERTY.stick_values];
	
	//Check the device type
	if (_type == MIS_DEVICE_TYPE.controller)
		{
		//Inputs
		var _buttons = mis_data().controller_inputs;
		for(var m = 0; m < MIS_INPUT.LENGTH; m++)
			{
			//Pressed buttons
			_inputs[@ m] = gamepad_button_check_pressed_array(_port, _buttons[@ m]);
			
			//Held buttons
			if (gamepad_button_check_array(_port, _buttons[@ m]))
				{
				_inputs[@ m + MIS_INPUT.LENGTH] += 1;
				} 
			else
				{
				_inputs[@ m + MIS_INPUT.LENGTH] = 0;
				}
			}
		
		//Stick Values
		_stick.x = clamp
			(
			gamepad_axis_value(_port, gp_axislh) +
			sign
				(
				gamepad_button_check(_port, gp_padr) -
				gamepad_button_check(_port, gp_padl),
				),
			-1,
			1,
			);
		_stick.y = clamp
			(
			gamepad_axis_value(_port, gp_axislv) +
			sign
				(
				gamepad_button_check(_port, gp_padd) -
				gamepad_button_check(_port, gp_padu),
				),
			-1,
			1,
			);
		var _len = point_distance(0, 0, _stick.x, _stick.y);
		if (_len > mis_data().controller_deadzone) 
			{
			_stick.hold += 1;
			if (_stick.hold == 1) 
				{
				_stick.press = true;
				} 
			else 
				{
				_stick.press = false;
				}
			} 
		else 
			{
			_stick.press = false;
			_stick.hold = 0;
			}
		} 
	else if (_type == MIS_DEVICE_TYPE.keyboard) 
		{
		//Inputs
		var _keys = mis_data().keyboard_inputs;
		for(var m = 0; m < MIS_INPUT.LENGTH; m++) 
			{
			//Pressed keys
			_inputs[@ m] = keyboard_check_pressed_array(_keys[@ m]);
			
			//Held keys
			if (keyboard_check_array(_keys[@ m])) 
				{
				_inputs[@ m + MIS_INPUT.LENGTH] += 1;
				} 
			else 
				{
				_inputs[@ m + MIS_INPUT.LENGTH] = 0;
				}
			}
		
		//Stick Values
		var _key_stick = mis_data().keyboard_stick;
		_stick.x = sign(keyboard_check_array(_key_stick[@ 0]) - keyboard_check_array(_key_stick[@ 1]));
		_stick.y = sign(keyboard_check_array(_key_stick[@ 3]) - keyboard_check_array(_key_stick[@ 2]));
		var _press_stick = { x : 0, y : 0 };
		_press_stick.x = sign(keyboard_check_pressed_array(_key_stick[@ 0]) - keyboard_check_pressed_array(_key_stick[@ 1]));
		_press_stick.y = sign(keyboard_check_pressed_array(_key_stick[@ 3]) - keyboard_check_pressed_array(_key_stick[@ 2]));
		var _len = point_distance(0, 0, _stick.x, _stick.y);
		var _press_len = point_distance(0, 0, _press_stick.x, _press_stick.y);
		if (_len != 0) 
			{
			_stick.hold += 1;
			//Pressed keys overide the direction of the normal keys
			if (_press_len != 0) 
				{
				if (abs(_press_stick.x) > abs(_stick.x)) then _stick.x = _press_stick.x;
				if (abs(_press_stick.y) > abs(_stick.y)) then _stick.y = _press_stick.y;
				_stick.press = true;
				_stick.hold = 1;
				} 
			else if (_stick.hold == 1) 
				{
				_stick.press = true;
				} 
			else 
				{
				_stick.press = false;
				}
			} 
		else 
			{
			_stick.press = false;
			_stick.hold = 0;
			}
		}
	else if (_type == MIS_DEVICE_TYPE.custom)
		{
		//Run the custom function
		var _custom = _device[@ MIS_DEVICE_PROPERTY.custom];
		if (is_struct(_custom) && variable_struct_exists(_custom, "update_function"))
			{
			_custom[$ "update_function"](_device);
			}
		}
	else crash("[obj_mis_system: Begin Step] Invalid MIS device type (", _type, ")");
	}
/* Copyright 2023 Springroll Games / Yosi */