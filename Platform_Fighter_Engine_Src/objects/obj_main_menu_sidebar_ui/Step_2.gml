///@description Inputs/Animation
if (menu_active)
	{
	//Inputs
	var _array = mis_devices_get_array();
	for(var i = 0; i < array_length(_array); i++)
		{
		var _id = _array[@ i];
		var _confirm = mis_device_input(_id, MIS_INPUT.confirm);
		var _start = mis_device_input(_id, MIS_INPUT.start);
		var _back = mis_device_input(_id, MIS_INPUT.back);
		var _stickv = (mis_device_stick_press_repeated(_id).y);
		var _ud = sign(mis_device_stick_values(_id).y);
		
		if (_stickv)
			{
			menu_sound_play(snd_menu_move);
			//Exception for the current choice being at -1
			if (menu_choice_current[@ i] == -1 && _ud == -1)
				{
				menu_choice_current[@ i] = (array_length(menu_choices) - 1);
				}
			else
				{
				menu_choice_current[@ i] = modulo(menu_choice_current[@ i] + _ud, array_length(menu_choices));
				}
			
			//Skip over web choices
			if (web_export || true)
				{
				while(!menu_choices[@ menu_choice_current[@ i]].web)
					{
					menu_choice_current[@ i] = modulo(menu_choice_current[@ i] + _ud, array_length(menu_choices));
					}
				}
			}
		if (menu_active_frame > 0)
			{
			if (_confirm || _start)
				{
				menu_sound_play(snd_menu_select);
				main_menu_sidebar_choose(menu_choice_current[@ i]);
				menu_active = false;
				exit;
				}
			if (_back)
				{
				menu_active = false;
				exit;
				}
			}
		}
	
	//Animation
	x = lerp(x, 0, 0.3);
	
	//Frame counter
	menu_active_frame++;
	}
else
	{
	//Animation
	x = lerp(x, menu_inactive_x, 0.3);
	
	//Frame counter
	menu_active_frame = 0;
	}
/* Copyright 2023 Springroll Games / Yosi */