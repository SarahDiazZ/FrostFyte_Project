///@description Update
if (!visible) then exit;

//Check if any of the touch devices click inside the circle, and store which one does
for(var i = 0; i < touch_devices_limit; i++)
	{
	var _mx = device_mouse_x_to_gui(i);
	var _my = device_mouse_y_to_gui(i);
	
	//If the device started a click on this frame
	if (device_mouse_check_button_pressed(i, mb_left))
		{
		//If the click was within the anchored circle
		if (point_distance(anchor_x, anchor_y, _mx, _my) < stick_distance)
			{
			stick_device_index = i;
			
			//Relative
			if (touch_stick_type == TOUCH_STICK_TYPE.relative)
				{
				x = _mx;
				y = _my;
				}
			break;
			}
		}
	}

//Move the control stick if the touch device is still being held down
if (stick_device_index != -1)
	{
	if (device_mouse_check_button(stick_device_index, mb_left))
		{
		var _mx = device_mouse_x_to_gui(stick_device_index);
		var _my = device_mouse_y_to_gui(stick_device_index);
		var _dir = point_direction(x, y, _mx, _my);
		var _len = min(point_distance(x, y, _mx, _my) / stick_distance, 1);
		stick_x = lengthdir_x(_len, _dir);
		stick_y = lengthdir_y(_len, _dir);
		}
	else
		{
		stick_device_index = -1;
		}
	}

//Return control stick to neutral
if (stick_device_index == -1)
	{
	stick_x = lerp(stick_x, 0, 0.5);
	stick_y = lerp(stick_y, 0, 0.5);
	}

/* Copyright 2023 Springroll Games / Yosi */