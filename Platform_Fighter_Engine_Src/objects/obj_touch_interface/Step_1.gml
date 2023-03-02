///@description Run Interface

//Disabling the interface
/*
if (keyboard_check_released(vk_escape))
	{
	disable ^= true;
	with(obj_touch_button)
		{
		visible = !other.disable;
		}
	with(obj_touch_stick)
		{
		visible = !other.disable;
		}
		
	//Remove from MIS
	if (disable && mis_device_is_connected(mis_device_number))
		{
		mis_device_disconnect(mis_device_number);
		mis_device_number = -1;
		}
	}
*/
	
if (!disable)
	{
	//Running interface step events
	with(obj_touch_button)
		{
		event_user(Game_Event_Step);
		}
	with(obj_touch_stick)
		{
		event_user(Game_Event_Step);
		}

	//Add a custom device to the MIS
	if (mis_device_number == -1 || !mis_device_is_connected(mis_device_number))
		{
		var _custom_struct = 
			{
			update_function : touch_mis_update_function,
			};
		mis_device_number = mis_device_connect(MIS_DEVICE_TYPE.custom, 0, _custom_struct);
		}
	}
	
/* Copyright 2023 Springroll Games / Yosi */