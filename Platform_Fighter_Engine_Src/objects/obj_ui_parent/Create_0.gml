///@category UI
/*
The parent object for all UI objects.

There are 8 different UI objects:
	- obj_ui_button : Can be clicked on by UI Cursors, can display text
	- obj_ui_button_image : Can be clicked on by UI Cursors, can draw a sprite
	- obj_ui_fade : Covers the entire room with a color
	- obj_ui_group : Used as an "anchor position" for all UI instances in the same group
	- obj_ui_image : Can draw a sprite
	- obj_ui_label : Can display text
	- obj_ui_section : A single color rectangle
	- obj_ui_toast : Displays text for a brief amount of time
	
You can change specific properties for UI instances through the "Variable Definitions" tab in the Room Editor.
*/
///@description Calculate Group Position, Create Script, Add to List

assert(instance_number(obj_ui_runner) > 0, "[obj_ui_parent: Create] No instance of obj_ui_runner exists");

//Groups
ui_group_xoff = 0;
ui_group_yoff = 0;
ui_group_owner = noone;

if (group != -1)
	{
	with(obj_ui_group)
		{
		//Error catching
		assert
			(
			variable_instance_exists(id, "group"), 
			"[obj_ui_parent: Create] The instance of obj_ui_group with the group number ", 
			other.group, 
			" needs to be BEFORE the other UI instances with that group number in the instance creation order!",
			);
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
	
//Script / Function
if (is_method(ui_script_create) || script_exists(ui_script_create))
	{
	ui_script_create();
	}
	
//Add to the instances array
with(obj_ui_runner)
	{
	assert(variable_instance_exists(id, "ui_instances"), "[obj_ui_parent: Create] obj_ui_runner must be created before any ui instances");
	array_push(ui_instances, other.id);
	}
/* Copyright 2023 Springroll Games / Yosi */