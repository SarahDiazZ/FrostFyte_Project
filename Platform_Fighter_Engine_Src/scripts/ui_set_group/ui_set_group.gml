///@category UI
///@param {id} id			The UI instance to set the group of
///@param {int} group		The group number, or -1 for "no group"
/*
Sets the group of the given UI instance.
*/
function ui_set_group() {
	with(argument[0])
		{
		group = argument[1];
		if (group != -1)
			{
			with(obj_ui_group)
				{
				if (group == other.group)
					{
					other.ui_group_owner = id;
					break;
					}
				}
			if (ui_group_owner != noone)
				{
				ui_group_xoff = x - ui_group_owner.x;
				ui_group_yoff = y - ui_group_owner.y;
				}
			else
				{
				log("UI Group does not have owner!");
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */