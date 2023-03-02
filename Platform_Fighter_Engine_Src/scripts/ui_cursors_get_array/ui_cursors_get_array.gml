///@category UI
/*
Returns an array with the index number of every UI cursor.
*/
function ui_cursors_get_array() {
	with(obj_ui_runner)
		{
		var _array = [];
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			array_push(_array, cursors[| i][@ UI_CURSOR.index]);
			}
		return _array;
		}
	crash("obj_ui_runner did not exist when ui_cursors_get_array was called");
}
/* Copyright 2023 Springroll Games / Yosi */