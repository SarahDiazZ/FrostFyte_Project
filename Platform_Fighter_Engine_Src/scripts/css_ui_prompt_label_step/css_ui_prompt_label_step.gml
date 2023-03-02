function css_ui_prompt_label_step() {
	//Only gives prompts for the first player
	var _array = css_players_get_array();
	if (array_length(_array) > 0)
		{
		//Find the player's window
		var _state = undefined;
		with(obj_css_player_window)
			{
			if (player_id == _array[@ 0])
				{
				//Grab the state
				_state = state;
				break;
				}
			}
			
		//If the state has changed
		if (player_window_last_state != _state)
			{
			player_window_last_state = _state;
			prompt_flash = 1;
			
			var _device_id = css_player_get(_array[@ 0], CSS_PLAYER.custom).device_id;
			if (_device_id == -1) then return; //CPUs won't trigger the prompts
			var _device_type = mis_device_get(_device_id, MIS_DEVICE_PROPERTY.device_type);
		
			//Uses the menu macros
			var _confirm, _cancel, _option, _remove;
			if (_device_type == MIS_DEVICE_TYPE.controller)
				{
				var _spr = spr_icon_input_button_universal;
				_confirm = [_spr, gamepad_button_number(menu_confirm_button)];
				_cancel = [_spr, gamepad_button_number(menu_back_button)];
				_option = [_spr, gamepad_button_number(menu_option_button)];
				_remove = [_spr, gamepad_button_number(menu_remove_button)];
				}
			else if (_device_type == MIS_DEVICE_TYPE.keyboard)
				{
				_confirm = key_to_string(menu_confirm_key, true); 
				_cancel = key_to_string(menu_back_key, true);
				_option = key_to_string(menu_option_key, true);
				_remove = key_to_string(menu_remove_key, true);
				}
			else if (_device_type == MIS_DEVICE_TYPE.custom)
				{
				_confirm = "A";
				_cancel = "B";
				_option = "Y";
				_remove = "X";
				}
			else crash("[css_ui_prompt_label_step] Invalid MIS device type (", _device_type, ")");
			
			//Change text based on the state
			switch(_state)
				{
				case CSS_PLAYER_WINDOW_STATE.select_profile:
					text = [_confirm, ": Select, ", _cancel, ": Back, ", _option, ": New, ", _remove, ": Delete"];
					break;
				case CSS_PLAYER_WINDOW_STATE.controls:
					text = [_confirm, ": Change, ", _cancel, ": Back"];
					break;
				case CSS_PLAYER_WINDOW_STATE.create_profile:
					text = [_confirm, ": Select, ", _cancel, ": Delete, ", _option, ": Create, ", _remove, ": Cancel"];
					break;
				case CSS_PLAYER_WINDOW_STATE.control_set:
					text = [_remove, ": Cancel"];
					break;
				default: text = []; break;
				}
			}
		else
			{
			//Handle animations
			prompt_flash = lerp(prompt_flash, 0, 0.1);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */