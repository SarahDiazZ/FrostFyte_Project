///@category UI
///@param {int} index		The index number of the UI cursor to get the x position of
/*
Returns the x position of the UI cursor with the given index number.
*/
function ui_cursor_x() {
	with(obj_ui_runner)
		{
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			var _cursor = cursors[| i];
			if (_cursor[UI_CURSOR.index] == argument[0])
				{
				return _cursor[UI_CURSOR.x];
				}
			}
		return undefined;
		}
	crash("obj_ui_runner did not exist when ui_cursor_x was called");
}
/* Copyright 2023 Springroll Games / Yosi */