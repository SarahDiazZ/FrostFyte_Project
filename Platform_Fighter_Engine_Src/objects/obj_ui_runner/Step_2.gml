///@description
//Clear variables
with(obj_ui_button)
	{
	ui_clicked = false;
	array_resize(ui_clicked_array, 0);
	ui_hovered = false;
	array_resize(ui_hovered_array, 0);
	ui_click_hold = false;
	array_resize(ui_click_hold_array, 0);
	}
	
//Cursor collisions
for(var i = 0; i < ds_list_size(cursors); i++)
	{
	var _cursor = cursors[| i];
	var _x = _cursor[UI_CURSOR.x];
	var _y = _cursor[UI_CURSOR.y];
	var _clicked = _cursor[UI_CURSOR.clicked];
	var _held = _cursor[UI_CURSOR.held_time];
	var _index = _cursor[UI_CURSOR.index];
	
	ds_list_clear(ui_col_list);
	if (collision_point_list(_x, _y, obj_ui_button, false, true, ui_col_list, false))
		{
		//Object with the lowest depth counts as being hovered
		var _lowest = ui_col_list[| 0];
		var _lowest_depth = _lowest.ui_depth;
		for(var m = 1; m < ds_list_size(ui_col_list); m++)
			{
			var _ui = ui_col_list[| i];
			if (_ui.ui_depth <= _lowest_depth)
				{
				_lowest_depth = _ui.ui_depth;
				_lowest = _ui;
				}
			}
			
		//Cursor Number Check
		with(_lowest)
			{
			//Make sure the cursor is allowed to click on the button
			if (_index == index || _index == -1 || anyone_can_interact)
				{
				//Hover script
				ui_hovered = true;
				array_push(ui_hovered_array, _index);
			
				//Click script
				if (_clicked)
					{
					ui_clicked = true;
					array_push(ui_clicked_array, _index);
					}
				if (_held > 0 || _clicked)
					{
					ui_click_hold = true;
					array_push(ui_click_hold_array, _index);
					}
				}
			}
		}
	}
	
//Step script
var _len = array_length(ui_instances);
for(ui_instance_current = _len - 1; ui_instance_current >= 0; ui_instance_current--)
	{
	with(ui_instances[@ ui_instance_current])
		{
		//We need to check if the instance exists in case the UI instance was destroyed by a different UI instance earlier in the with loop.
		if (instance_exists(id))
			{
			if (is_method(ui_script_step) || script_exists(ui_script_step))
				{
				ui_script_step();
				}
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */