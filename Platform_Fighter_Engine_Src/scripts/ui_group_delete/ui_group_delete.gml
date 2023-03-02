///@category UI
///@param {int} group		The number of the group to delete
/*
Deletes all UI instances that have the given group number.
*/
function ui_group_delete() {
	var _group = argument[0];
	if (_group != -1)
		{
		with(obj_ui_parent)
			{
			if (group == _group) then instance_destroy();
			}
		with(obj_ui_group)
			{
			if (group == _group) then instance_destroy();
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */