///@description
if (keyboard_check_pressed(vk_enter)) then started_intro = true;
if (started_intro)
	{
	frame++;
	if (frame > 110)
		{
		//Touch controls setup
		if (touch_controls_enable)
			{
			room_goto(rm_touch_interface);
			exit;
			}
		else
			{
			room_goto_next();
			exit;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */