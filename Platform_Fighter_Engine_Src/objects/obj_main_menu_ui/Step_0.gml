///@description
var _array = mis_devices_get_array();
for(var i = 0; i < array_length(_array); i++)
	{
	var _cursor = i;
	var _device_id = _array[@ i];
	var _stick_value = mis_device_stick_values(_device_id);
	var _x = 0;
	var _y = 0;
	if (_stick_value.hold > 0)
		{
		var _dir = point_direction(0, 0, _stick_value.x, _stick_value.y);
		var _len = ui_cursor_speed_calculate(_stick_value.x, _stick_value.y, menu_cursor_speed);
		_x = lengthdir_x(_len, _dir);
		_y = lengthdir_y(_len, _dir);
		}
	ui_cursor_update
		(
		_cursor,
		clamp(ui_cursor_x(_cursor) + _x, 0, room_width - 1),
		clamp(ui_cursor_y(_cursor) + _y, 0, room_height - 1),
		false,
		mis_device_input(_device_id, MIS_INPUT.confirm),
		mis_device_input(_device_id, MIS_INPUT.confirm, true),
		);
	}
/* Copyright 2023 Springroll Games / Yosi */