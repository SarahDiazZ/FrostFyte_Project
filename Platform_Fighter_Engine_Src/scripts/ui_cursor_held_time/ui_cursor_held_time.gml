///@category UI
///@param {int} index		The index number of the UI cursor to check
/*
Returns the amount of time the UI cursor with the given index number has been held down.
*/
function ui_cursor_held_time() {
	with(obj_ui_runner)
		{
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			var _cursor = cursors[| i];
			if (_cursor[UI_CURSOR.index] == argument[0])
				{
				return _cursor[UI_CURSOR.held_time];
				}
			}
		return undefined;
		}
	crash("obj_ui_runner did not exist when ui_cursor_held_time was called");
}
/* Copyright 2023 Springroll Games / Yosi */