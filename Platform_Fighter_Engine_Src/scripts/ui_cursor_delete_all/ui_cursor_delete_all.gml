///@category UI
/*
Deletes all of the UI cursors.
*/
function ui_cursor_delete_all() {
	with(obj_ui_runner)
		{
		ds_list_clear(cursors);
		return;
		}
	crash("obj_ui_runner did not exist when ui_cursor_delete_all was called");
}
/* Copyright 2023 Springroll Games / Yosi */