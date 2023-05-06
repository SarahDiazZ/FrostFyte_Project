///@category UI
///@param {int} index		The index number of the UI cursor to check
/*
Returns true if the UI cursor with the given index number is clicking.
*/
function ui_cursor_clicked() {
	with(obj_ui_runner)
		{
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			var _cursor = cursors[| i];
			if (_cursor[UI_CURSOR.index] == argument[0])
				{
				return _cursor[UI_CURSOR.clicked];
				}
			}
		return false;
		}
	crash("obj_ui_runner did not exist when ui_cursor_clicked was called");
}
/* Copyright 2023 Springroll Games */