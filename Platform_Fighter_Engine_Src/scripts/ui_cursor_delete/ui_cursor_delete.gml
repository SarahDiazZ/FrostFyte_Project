///@category UI
///@param {int} index		The index number of the UI cursor to delete
/*
Deletes the UI cursor with the given index number.
Returns false if no cursor was found with the correct index.
*/
function ui_cursor_delete() {
	with(obj_ui_runner)
		{
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			var _cursor = cursors[| i];
			if (_cursor[UI_CURSOR.index] == argument[0])
				{
				ds_list_delete(cursors, i);
				return true;
				}
			}
		return false;
		}
	crash("obj_ui_runner did not exist when ui_cursor_delete was called");
}
/* Copyright 2023 Springroll Games / Yosi */