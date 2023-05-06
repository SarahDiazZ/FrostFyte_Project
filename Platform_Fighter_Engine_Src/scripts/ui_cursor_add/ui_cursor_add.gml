///@category UI
///@param {int} index		The index of the cursor
///@param {real} x			The x position to create the cursor at
///@param {real} y			The y position to create the cursor at
/*
Creates a new UI cursor at the given position with the given index number.
Returns the position of the cursor in the <obj_ui_runner> cursors list.
*/
function ui_cursor_add() {
	with(obj_ui_runner)
		{
		var _new = [];
		_new[@ UI_CURSOR.index] = argument[0];
		_new[@ UI_CURSOR.x] = argument[1];
		_new[@ UI_CURSOR.y] = argument[2];
		_new[@ UI_CURSOR.clicked] = false;
		_new[@ UI_CURSOR.held_time] = 0;
		ds_list_add(cursors, _new);
		return (ds_list_size(cursors) - 1);
		}
	crash("obj_ui_runner did not exist when ui_cursor_add was called");
}
/* Copyright 2023 Springroll Games */