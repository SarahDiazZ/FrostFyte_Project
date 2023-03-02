///@category UI
///@param {id} id				The instance to set the colors of
///@param {color} normal		The default color
///@param {color} hover			The color when hovered
///@param {color} clicked		The color when clicked
///@param {int} [group]			The number of the UI group to affect
/*
Sets the colors for the given UI button instance.
If you specify a group, it will instead set the colors for all buttons in that group.
*/
function ui_button_colors_set() {
	var _id = argument[0];
	var _n = argument[1];
	var _h = argument[2];
	var _c = argument[3];
	var _group = argument_count > 4 ? argument[4] : -1;

	if (_group != -1)
		{
		with(obj_ui_button)
			{
			if (group == _group)
				{
				color_normal = _n;
				color_hover = _h;
				color_clicked = _c;
				image_blend = color_normal;
				}
			}
		}
	else
		{
		_id.color_normal = _n;
		_id.color_hover = _h;
		_id.color_clicked = _c;
		_id.image_blend = color_normal;
		}
}
/* Copyright 2023 Springroll Games / Yosi */