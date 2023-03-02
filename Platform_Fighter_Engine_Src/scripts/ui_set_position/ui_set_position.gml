///@category UI
///@param {id} id				The instance to move
///@param {real} x				The new x position
///@param {real} y				The new y position
///@param {int] [group]			The group number to move
/*
Sets the x and y of the given UI instance.
If a group is specified, all UI instances of that group will be moved to that x and y.
*/
function ui_set_position() {
	var _id = argument[0];
	var _x = argument[1];
	var _y = argument[2];
	var _group = argument_count > 3 ? argument[3] : -1;

	if (_group != -1)
		{
		with(obj_ui_group)
			{
			if (group == _group)
				{
				x = _x;
				y = _y;
				break;
				}
			}
		with(obj_ui_parent)
			{
			if (group == _group)
				{
				x = ui_group_owner.x + ui_group_xoff;
				y = ui_group_owner.y + ui_group_yoff;
				}
			}
		}
	else
		{
		_id.x = _x;
		_id.y = _y;
		}
}
/* Copyright 2023 Springroll Games / Yosi */