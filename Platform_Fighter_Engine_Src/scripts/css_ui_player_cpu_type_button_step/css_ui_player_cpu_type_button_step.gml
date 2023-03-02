function css_ui_player_cpu_type_button_step() {
	ui_button_step();

	if (ui_clicked)
		{
		menu_sound_play(snd_menu_select);
		
		//Change the type
		var _type = modulo(css_player_get(player_id, CSS_PLAYER.cpu_type) + 1, CPU_TYPE.LENGTH);
		if (_type == CPU_TYPE.input_test && !setting().debug_mode_enable)
			{
			_type = modulo(_type + 1, CPU_TYPE.LENGTH);
			}
		css_player_set(player_id, CSS_PLAYER.cpu_type, _type);
		
		//Toast message
		instance_destroy(obj_ui_toast);
		with(instance_create_layer(x + (sprite_width div 2), y, "UI_Above_Layer", obj_ui_toast))
			{
			lifetime = 45;
			text = "UNKNOWN CPU TYPE";
			switch(_type)
				{
				case CPU_TYPE.airdodge:
					text = "AIRDODGE";
					break;
				case CPU_TYPE.attack:
					text = "NORMAL";
					break;
				case CPU_TYPE.di_in:
					text = "DI: IN";
					break;
				case CPU_TYPE.di_out:
					text = "DI: OUT";
					break;
				case CPU_TYPE.di_random:
					text = "DI: RANDOM";
					break;
				case CPU_TYPE.idle:
					text = "IDLE";
					break;
				case CPU_TYPE.parry_ult:
					text = "PARRY (ULT)";
					break;
				case CPU_TYPE.shield_hold:
					text = "SHIELD HOLD";
					break;
				case CPU_TYPE.shield_attack:
					text = "SHIELD ATTACK";
					break;
				case CPU_TYPE.shield_grab:
					text = "SHIELD GRAB";
					break;
				case CPU_TYPE.input_test:
					text = "INPUT TEST (DEBUG)";
					break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */