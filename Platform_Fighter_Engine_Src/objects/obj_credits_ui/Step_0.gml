///@description Interactions

//Get input from all MIS devices
var _confirm = false;
var _back = false;
var _remove = false;
var _select = false;
var _gy = 0;
var _gy_pressed = false;
var _array = mis_devices_get_array();
for(var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i];
	var _values = mis_device_stick_values(_id);
	if (_values.hold > 0)
		{
		_gy += _values.y;
		if (!_gy_pressed) then _gy_pressed = _values.press;
		}
	if (!_confirm) then _confirm = mis_device_input(_id, MIS_INPUT.confirm);
	if (!_back) then _back = mis_device_input(_id, MIS_INPUT.back);
	if (!_remove) then _remove = mis_device_input(_id, MIS_INPUT.remove);
	if (!_select) then _select = mis_device_input(_id, MIS_INPUT.select);
	}
	
//Clicking on links
for(var i = 0; i < array_length(credits_links); i++)
	{
	var _link = credits_links[@ i];
	if ((point_in_rectangle(mouse_x, mouse_y, x + _link.left, y + _link.top, x + _link.right, y + _link.bottom) && mouse_check_button_pressed(mb_left)) ||
		(credits_current_link == i && _confirm))
		{
		url_open(_link.url);
		exit;
		}
	}
	
//Scrolling
if (_gy != 0)
	{
	credits_scroll = clamp(credits_scroll - (_gy * 9), -credits_height + 128, 0);
	y = ystart + credits_scroll;
	if (_gy_pressed)
		{
		var _links_on_page = [];
		for(var i = 0; i < array_length(credits_links); i++)
			{
			var _link = credits_links[@ i];
			if (-credits_scroll + room_height > _link.top && -credits_scroll < _link.bottom)
				{
				array_push(_links_on_page, i);
				}
			}
		if (array_length(_links_on_page) > 0)
			{
			credits_current_link = clamp(credits_current_link + sign(_gy), _links_on_page[@ 0], _links_on_page[@ array_length(_links_on_page) - 1]);
			}
		}
	}
if (mouse_check_button_pressed(mb_left))
	{
	credits_mouse_drag_start_y = mouse_y;
	credits_scroll_start_y = credits_scroll;
	}
if (mouse_check_button(mb_left))
	{
	credits_scroll = clamp(credits_scroll_start_y + (mouse_y - credits_mouse_drag_start_y), -credits_height + 128, 0);
	y = ystart + credits_scroll;
	}

//Back to main menu
if (_back || _remove || _select)
	{
	room_goto(rm_main_menu);
	exit;
	}


/* Copyright 2023 Springroll Games / Yosi */