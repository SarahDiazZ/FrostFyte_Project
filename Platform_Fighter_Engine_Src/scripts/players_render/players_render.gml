///@category Player Rendering
///@param {int} list		The index of the ds list to use
/*
Renders all of the players currently assigned to the calling renderer object.
Please note: This function can ONLY be used by renderer objects.
*/
function players_render() {
	var _l = argument[0];
	for(var i = 0; i < ds_list_size(_l); i++)
		{
		var _player = _l[| i];
		with(_player)
			{
			if (renderer == other.object_index)
				{
				event_user(Game_Event_Draw);
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */