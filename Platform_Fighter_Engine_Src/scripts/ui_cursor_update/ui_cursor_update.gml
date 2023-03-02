///@category UI
///@param {int} index			The index number of the UI cursor to update
///@param {real} x				The x position
///@param {real} y				The y position
///@param {bool} relative		Whether to set the cursor's position relative to its current x and y or not
///@param {bool} clicked		Whether the cursor is currently clicking
///@param {int} held			The number of frames the cursor has been held down
/*
Updates the UI cursor with the given index number to have the given values.
*/
function ui_cursor_update() {
	with(obj_ui_runner)
		{
		for(var i = 0; i < ds_list_size(cursors); i++)
			{
			var _cursor = cursors[| i];
			if (_cursor[UI_CURSOR.index] == argument[0])
				{
				//Position
				if (argument[3])
					{
					_cursor[@ UI_CURSOR.x] = (_cursor[UI_CURSOR.x] + argument[1]);
					_cursor[@ UI_CURSOR.y] = (_cursor[UI_CURSOR.y] + argument[2]);
					}
				else
					{
					_cursor[@ UI_CURSOR.x] = argument[1];
					_cursor[@ UI_CURSOR.y] = argument[2];
					}
	
				//Clicked / Held
				_cursor[@ UI_CURSOR.clicked] = argument[4];
				_cursor[@ UI_CURSOR.held_time] = argument[5];
				
				return true;
				}
			}
		return false;
		}
	crash("obj_ui_runner did not exist when ui_cursor_update was called");
}
/* Copyright 2023 Springroll Games / Yosi */