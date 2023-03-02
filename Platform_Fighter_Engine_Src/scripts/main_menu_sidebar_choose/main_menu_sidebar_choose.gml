///@category Menus
///@param {int} choice_number			The number of the choice in the menu array
/*
Chooses an option from the main menu sidebar.
*/
function main_menu_sidebar_choose() {
	var _choice = argument[0];
	switch(_choice)
		{
		case -1:
			//The current choice default is -1
			break;
		case 0:
			//Local match
			if (room != rm_css) 
				{
				room_goto(rm_css);
				}
			break;
		case 1:
			//Online quickplay match
			break;
		case 2:
			//Online lobby
			break;
		case 3:
			//Replays
			if (room != rm_replays)
				{
				room_goto(rm_replays);
				}
			break;
		case 4:
			//Options
			if (room != rm_options)
				{
				room_goto(rm_options);
				}
			break;
		case 5:
			//Main Menu
			if (room != rm_main_menu)
				{
				room_goto(rm_main_menu);
				}
			break;
		case 6:
			//Quit
			game_end();
			break;
		default: crash("[main_menu_sidebar_choose] Invalid choice (", _choice, ")");
		}
	return;
}
/* Copyright 2023 Springroll Games / Yosi */