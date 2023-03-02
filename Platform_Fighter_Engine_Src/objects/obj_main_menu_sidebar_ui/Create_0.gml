///@category Menus
/*
This object displays the Main Menu Sidebar. Place it in any menu room you want the bar to be in.
You can use the functions <main_menu_sidebar_activate> and <main_menu_sidebar_choose> to manually control it, but the cursors and animations are all automatic.
*/
///@description
only_one();
mis_init();
mis_auto_connect_enable(true);

menu_choices =
	[
	{ sprite : spr_sidebar_local, text : "LOCAL", web : true },
	{ sprite : spr_sidebar_quickplay, text : "QUICKPLAY", web : false },
	{ sprite : spr_sidebar_private_lobby, text : "LOBBY", web : false },
	{ sprite : spr_sidebar_replays, text : "REPLAYS", web : true },
	{ sprite : spr_sidebar_options, text : "OPTIONS", web: true },
	{ sprite : spr_sidebar_main_menu, text : "MAIN MENU", web : true },
	{ sprite : spr_sidebar_exit, text : "EXIT", web : true },
	];
	
menu_choice_current = array_create(max_players, -1);
menu_active = false;
menu_active_frame = 0;
menu_inactive_x = -170;
x = menu_inactive_x;

//Menu music
if (!audio_is_playing(song_menu)) 
	{
	audio_play_sound_adjusted(song_menu, 0, true, audiogroup_music);
	}
/* Copyright 2023 Springroll Games / Yosi */