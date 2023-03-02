///@desc Logic
if (disable) then exit;

//Mouse hover
var _mx = display_mouse_get_x();
var _my = display_mouse_get_y();
var _wx = window_get_x();
var _wy = window_get_y();
var _gx = device_mouse_x_to_gui(0);
var _gy = device_mouse_y_to_gui(0);
if (point_in_rectangle(_gx, _gy, 0, 0, screen_width, bar_height + 8))
	{
	window_hover = true;
	}
else
	{
	window_hover = false;
	}
	
if (window_hover)
	{
	var _button = "";
	//Hovering buttons
	//Exit
	if (point_in_rectangle(_gx, _gy, screen_width - 48, 0, screen_width, bar_height))
		{
		_button = "exit";
		button_exit_fade = lerp(button_exit_fade, 1, 0.1);
		}
	else
		{
		button_exit_fade = lerp(button_exit_fade, 0, 0.2);
		}
	//Full window
	if (point_in_rectangle(_gx, _gy, screen_width - 96, 0, screen_width - 48, bar_height))
		{
		_button = "full";
		button_full_fade = lerp(button_full_fade, 1, 0.1);
		}
	else
		{
		button_full_fade = lerp(button_full_fade, 0, 0.2);
		}
	//Size
	if (point_in_rectangle(_gx, _gy, screen_width - 144, 0, screen_width - 96, bar_height))
		{
		_button = "size";
		button_size_fade = lerp(button_size_fade, 1, 0.1);
		}
	else
		{
		button_size_fade = lerp(button_size_fade, 0, 0.2);
		}
		
	//Clicking
	if (mouse_check_button_released(mb_left))
		{
		//Exiting
		if (_button == "exit")
			{
			game_end();
			}
		//Full window
		else if (_button == "full")
			{
			window_set_fullscreen(!window_get_fullscreen());
			}
		//Resizing
		else if (_button == "size")
			{
			var _scale = (window_get_width() div screen_width);
			_scale = modulo(_scale, 4) + 1;
			var _ww = screen_width * _scale;
			var _wh = screen_height * _scale;
			window_set_size(_ww, _wh);
			//Center the window
			window_set_position
				(
				(display_get_width() div 2) - (_ww div 2),
				(display_get_height() div 2) - (_wh div 2),
				);
			}
		}
	//Dragging the window
	else if (mouse_check_button_pressed(mb_left))
		{
		if (_button == "" && !window_dragged)
			{
			window_dragged = true;
			window_drag_x = _mx;
			window_drag_y = _my;
			window_start_x = _wx;
			window_start_y = _wy;
			}
		}
	//Fade in
	window_fade = lerp(window_fade, 1, 0.2);
	}
else
	{
	//Fade out
	if (!window_dragged)
		{
		window_fade = lerp(window_fade, 0, 0.1);
		if (window_fade < 0.01) then window_fade = 0;
		}
	button_exit_fade = lerp(button_exit_fade, 0, 0.2);
	button_full_fade = lerp(button_full_fade, 0, 0.2);
	button_size_fade = lerp(button_size_fade, 0, 0.2);
	}

//Window dragging
if (window_dragged)
	{
	if (!mouse_check_button(mb_left))
		{
		window_dragged = false;
		}
	else
		{
		window_set_position
			(
			window_start_x + (_mx - window_drag_x),
			window_start_y + (_my - window_drag_y),
			);
		}
	}
	
	
//Escaping Fullscreen / Reset window
if (keyboard_check_pressed(vk_escape))
	{
	window_set_size(screen_width, screen_height);
	window_set_fullscreen(false);
	}
/* Copyright 2023 Springroll Games / Yosi */