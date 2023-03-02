///@description
//Get input from all MIS devices
var _confirm = false;
var _confirm_hold = 0;
var _back = false;
var _start = false;
var _gx = 0;
var _gy = 0;
var _array = mis_devices_get_array();
for(var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i];
	var _values = mis_device_stick_values(_id);
	if (_values.hold > 0)
		{
		_gx += _values.x;
		_gy += _values.y;
		}
	if (!_confirm) then _confirm = mis_device_input(_id, MIS_INPUT.confirm);
	if (_confirm_hold == 0) then _confirm_hold = mis_device_input(_id, MIS_INPUT.confirm, true);
	if (!_back) then _back = mis_device_input(_id, MIS_INPUT.back);
	if (!_start) then _start = mis_device_input(_id, MIS_INPUT.start);
	}
	
var _x = ui_cursor_x(0);
var _y = ui_cursor_y(0);

//Cursor speed
var _dir = point_direction(0, 0, _gx, _gy);
var _len = ui_cursor_speed_calculate(_gx, _gy, menu_cursor_speed);
_gx = lengthdir_x(_len, _dir);
_gy = lengthdir_y(_len, _dir);

//Update Cursor
ui_cursor_update
	(
	0,
	clamp(_x + _gx, 0, room_width - 1),
	clamp(_y + _gy, 0, room_height - 1),
	false,
	_confirm,
	_confirm_hold,
	);
	
//Hovering over stages
var _inst = instance_position(ui_cursor_x(0), ui_cursor_y(0), obj_sss_zone);
if (_inst != noone)
	{
	_inst.selected_animation_time = 1;
	
	//Name
	var _data = stage_data_get(_inst.stage);
	stage_name_label.text = _data.name;
		
	//Selecting a stage
	if (_confirm || _start)
		{
		menu_sound_play(snd_menu_select);
		setting().match_stage = _inst.stage;
		game_begin(rm_css, false, false);
		exit;
		}
	}
	
//Go back
if (_back)
	{
	menu_sound_play(snd_menu_back);
	room_goto(rm_css);
	}
/* Copyright 2023 Springroll Games / Yosi */