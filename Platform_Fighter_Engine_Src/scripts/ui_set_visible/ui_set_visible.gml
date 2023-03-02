///@category UI
///@param {id} id				The instance to change the visibility of
///@param {bool} value			Whether the object is visible or not
///@param {int} [group]			The group number to affect
/*
Changes the visibility of the given UI instance.
If a group is specified, all UI instances of that group will be affected.
*/
function ui_set_visible() {
	var _id = argument[0];
	var _val = argument[1];
	var _group = argument_count > 2 ? argument[2] : -1;

	if (_group != -1)
		{
		with(obj_ui_parent)
			{
			if (group == _group)
				{
				visible = _val;
				}
			}
		}
	else
		{
		_id.visible = _val;
		}
}
/* Copyright 2023 Springroll Games / Yosi */