///@category UI
///@param {int} index			The index number of the UI cursor to affect
///@param {int} property		The property to set, from the UI_CURSOR enum
///@param {any} value			The value to set the property to
/*
Sets the given property for the UI cursor with the given index.
*/
function ui_cursor_set() {
	with(obj_ui_runner)
		{
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			var _cursor = cursors[| i];
			if (_cursor[UI_CURSOR.index] == argument[0])
				{
				_cursor[@ argument[1]] = argument[2];
				return true;
				}
			}
		return false;
		}
	crash("obj_ui_runner did not exist when ui_cursor_set was called");
}
/* Copyright 2023 Springroll Games / Yosi */