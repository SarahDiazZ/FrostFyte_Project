///@desc Deletes all of the CSS player UI and recreates it.
function css_ui_refresh() {
	var _array = css_players_get_array();
	var _size = (array_length(_array) <= 4 ? 0 : 1);

	with(obj_css_ui)
		{
		for(var i = 0; i < array_length(_array); i++)
			{
			//Destroy existing UI
			var _id = _array[@ i];
			var _custom = css_player_get(_id, CSS_PLAYER.custom);
			var _group = _custom.group;
			var _index = _custom.cursor;
			ui_group_delete(_group);
		
			//Create new UI
			css_ui_create_player(i, _id, _group, _index, _size);
			}
		log("Refreshed CSS UI!");
		}
}
/* Copyright 2023 Springroll Games / Yosi */