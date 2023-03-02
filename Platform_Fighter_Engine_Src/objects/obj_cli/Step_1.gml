if (in_focus)
	{
	//Type in commands
	cli_text_set(cli, keyboard_string);
	autocomplete = cli_autocomplete(cli);
	
	//History
	if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down))
		{
		history_index = clamp
			(
			history_index + keyboard_check_pressed(vk_up) - keyboard_check_pressed(vk_down), 
			-1, 
			array_length(history) - 1,
			);
		if (history_index != -1)
			{
			cli_text_set(cli, history[@ history_index]);
			keyboard_string = history[@ history_index];
			}
		else
			{
			cli_text_set(cli, "");
			keyboard_string = "";
			}
		}
	
	//Copy / Paste
	if (keyboard_check(vk_control))
		{
		if (keyboard_check_pressed(ord("V")) && clipboard_has_text())
			{
			cli_text_set(cli, clipboard_get_text());
			keyboard_string = clipboard_get_text();
			}
		if (keyboard_check_pressed(ord("C")))
			{
			clipboard_set_text(cli_text_get(cli));
			}
		history_index = -1;
		}
	
	//Run commands
	if (keyboard_check_pressed(cli_key_enter))
		{
		if (cli_execute(cli))
			{
			array_insert(history, 0, cli_text_get(cli));
			if (array_length(history) > 10)
				{
				array_delete(history, 10, 1);
				}
			keyboard_string = "";
			cli_text_set(cli, "");
			in_focus = false;
			history_index = -1;
			}
		}
	}
	
//Toggle the CLI
if (keyboard_check_pressed(cli_key_toggle))
	{
	keyboard_string = "";
	cli_text_set(cli, "");
	autocomplete = [];
	in_focus ^= true;
	history_index = -1;
	}


/* Copyright 2023 Springroll Games / Yosi */