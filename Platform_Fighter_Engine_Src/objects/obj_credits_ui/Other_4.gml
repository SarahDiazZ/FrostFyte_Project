///@description
				
//Menu Input System
mis_init();
mis_auto_connect_enable(true);

//Background animation
menu_background_color_set($777777);

//Get the data from the Credits.txt file
var _string = string_file_load("credits.txt");
credits_tokens = [];

//Go character by character
var _token = "";
var _length = string_length(_string);
credits_height = 0;
for(var i = 0; i < _length; i++)
	{
	var _char = string_char_at(_string, 1);
	if (_char == "\n" ||
		_char == "\t" ||
		_char == "[" ||
		_char == "]" ||
		_char == "(" ||
		_char == ")" ||
		_char == "<" ||
		_char == ">")
		{
		if (_token != "") then array_push(credits_tokens, { text : _token, type : 0 });
		_token = "";
		array_push(credits_tokens, { text : _char, type : 1 });
		if (_char == "\n") then credits_height += 24;
		}
	else if (_char != "\r")
		{
		_token += _char;
		}
	_string = string_copy(_string, 2, _length);
	}

//Push any last characters
if (_token != "") then array_push(credits_tokens, { text : _token, type : 0 });
_token = "";

//Surface
credits_surf = surface_create(room_width, credits_height);
credits_rendered = false;

//Links
credits_links = [];
credits_current_link = -1;

//Scrolling
credits_scroll = 0;
credits_mouse_drag_start_y = 0;
credits_scroll_start_y = 0;


/* Copyright 2023 Springroll Games / Yosi */