///@category UI
///@param {int} index		The index number of the UI cursor to get the y position of
/*
Returns the y position of the UI cursor with the given index number.
*/
function ui_cursor_y() {
	with(obj_ui_runner)
		{
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			var _cursor = cursors[| i];
			if (_cursor[UI_CURSOR.index] == argument[0])
				{
				return _cursor[UI_CURSOR.y];
				}
			}
		return undefined;
		}
	crash("obj_ui_runner did not exist when ui_cursor_count was called");
}
/* Copyright 2023 Springroll Games / Yosi */