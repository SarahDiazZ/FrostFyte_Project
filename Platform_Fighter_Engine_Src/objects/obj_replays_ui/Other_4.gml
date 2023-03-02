///@description
				
//Menu Input System
mis_init();
mis_auto_connect_enable(true);

//Background animation
menu_background_color_set($E24AB5);

var _scan = replays_scan();
replay_array = _scan.replay_array;
replays_count = array_length(replay_array);
replay_current = 0;
replays_per_page = 10;
replay_scroll = 0;
replay_delete_time = 0;

replay_clip_number = _scan.clip_number;
replay_unknown_number = _scan.unknown_number;

replay_metadata = undefined;
replay_metadata_current = -1;

active = true;
/* Copyright 2023 Springroll Games / Yosi */