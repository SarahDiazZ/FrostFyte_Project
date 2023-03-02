///@description

//Menu Input System
mis_init();
mis_auto_connect_enable(true);
mis_device_disconnect_all();
mis_device_connect_callback_set
	(
	function(_device_id) 
		{
		//Add the UI cursor
		ui_cursor_add(mis_devices_count() - 1, room_width div 2, room_height div 2);
		}
	);
	
//Clean profiles
profile_clean_auto();

/* Copyright 2023 Springroll Games / Yosi */