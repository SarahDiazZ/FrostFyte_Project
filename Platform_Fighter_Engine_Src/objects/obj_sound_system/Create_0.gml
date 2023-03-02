///@category Sound System
/*
This object manages sound effects during matches to make sure sounds can't repeat or overlap too quickly.
Any sound effect played through <sound_system_play>, <game_sound_player>, or <hit_sfx_play> will use the sound system - using the built-in audio functions will ignore the sound system.
*/
///@description
sound_system_all_sounds = {};
sound_system_max_frame_count = 10;
/* Copyright 2023 Springroll Games / Yosi */