///@category Menus
/*
Handles the cursor on the main menu screen.
*/
only_one();

//Background animation
menu_background_color_set(c_ltgray);

//Menu music
if (!audio_is_playing(song_menu)) 
	{
	audio_play_sound_adjusted(song_menu, 0, true, audiogroup_music);
	}
/* Copyright 2023 Springroll Games / Yosi */