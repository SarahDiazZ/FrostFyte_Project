///@description
var _array = mis_devices_get_array();
for(var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i]; 
	var _type = mis_device_get(_id, MIS_DEVICE_PROPERTY.device_type);
	
	//Controller
	if (_type == MIS_DEVICE_TYPE.controller || _type == MIS_DEVICE_TYPE.custom)
		{
		var _confirm = mis_device_input_repeated(_id, MIS_INPUT.confirm);
		var _back = mis_device_input_repeated(_id, MIS_INPUT.back);
		var _option = mis_device_input_repeated(_id, MIS_INPUT.option);
		var _remove = mis_device_input_repeated(_id, MIS_INPUT.remove);
		var _start = mis_device_input_repeated(_id, MIS_INPUT.start);
		var _stickh = (mis_device_stick_press_repeated(_id).x);
		var _stickv = (mis_device_stick_press_repeated(_id).y);
		var _rl = sign(mis_device_stick_values(_id).x);
		var _ud = sign(mis_device_stick_values(_id).y);

		var _prev = inputter_current;
		if (_stickh)
			{
			menu_sound_play(snd_menu_move);
			inputter_current += (_rl);
			}
		if (_stickv)
			{
			menu_sound_play(snd_menu_move);
			inputter_current += (_ud * inputter_row_length);
			}
		if (inputter_current < 0 || inputter_current >= inputter_letter_count)
			{
			inputter_current = _prev;
			}
		
		//Adding new letters
		if (_confirm)
			{
			if (string_length(inputter_string) < inputter_max_length)
				{
				menu_sound_play(snd_menu_select);
				inputter_string += inputter_letters[@ inputter_current];
				}
			else
				{
				menu_sound_play(snd_menu_back);
				}
			}
	
		//Deleting letters
		if (_back || _remove)
			{
			if (string_length(inputter_string) > 0)
				{
				inputter_string = string_delete(inputter_string, string_length(inputter_string), 1);
				}
			else
				{
				//Submitting the default string
				inputter_callback(inputter_default, inputter_custom);
				instance_destroy();
				exit;
				}
			}
		
		//Submitting the string
		if (_start || _option)
			{
			if (string_length(inputter_string) > 0)
				{
				inputter_callback(inputter_string, inputter_custom);
				instance_destroy();
				exit;
				}
			}
		}
	//Keyboard
	else if (_type == MIS_DEVICE_TYPE.keyboard)
		{
		//Backspace
		if (keyboard_check(vk_backspace))
			{
			inputter_backspace_held_time += 1;
			}
		else
			{
			inputter_backspace_held_time = 0;
			}
		var _backspace_repeated = 
			(inputter_backspace_held_time == 1) || 
			(inputter_backspace_held_time > 10 && inputter_backspace_held_time % 6 == 0);
		
		if (_backspace_repeated)
			{
			if (string_length(inputter_string) > 0)
				{
				inputter_string = string_delete(inputter_string, string_length(inputter_string), 1);
				}
			else
				{
				//Submitting the default string
				inputter_callback(inputter_default, inputter_custom);
				instance_destroy();
				exit;
				}
			}
		
		//Get keyboard input directly
		if (keyboard_check_pressed(vk_anykey))
			{
			//Check that the key is valid
			var _char = key_to_string(keyboard_key);
			
			//Normal keys
			if (array_contains(inputter_letters, _char))
				{
				if (string_length(inputter_string) < inputter_max_length)
					{
					menu_sound_play(snd_menu_select);
					inputter_string += _char;
					}
				else
					{
					menu_sound_play(snd_menu_back);
					}
				}
			
			//Underscores (spacebar or -)
			if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(189))
				{
				if (array_contains(inputter_letters, "_"))
					{
					if (string_length(inputter_string) < inputter_max_length)
						{
						menu_sound_play(snd_menu_select);
						inputter_string += "_";
						}
					else
						{
						menu_sound_play(snd_menu_back);
						}
					}
				}
				
			//Enter
			if (keyboard_check_pressed(vk_enter))
				{
				if (string_length(inputter_string) > 0)
					{
					inputter_callback(inputter_string, inputter_custom);
					instance_destroy();
					exit;
					}
				}
			}
		}
	else crash("[obj_string_inputter: Begin Step] Invalid MIS device type (", _type, ")");
	}
/* Copyright 2023 Springroll Games / Yosi */