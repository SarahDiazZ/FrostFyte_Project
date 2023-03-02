///@category Player Engine Scripts
///@param {id} [player]			The instance id of the player to remove from the win screen order
/*
Removes the given player from the win screen order. If no player is specified, the calling <obj_player> will remove itself.
*/
function player_win_order_remove() {
	var _inst = argument_count > 0 ? argument[0] : id;
	if (_inst == noone) then _inst = id;
	
	if (object_is(_inst.object_index, obj_player))
		{
		with(_inst)
			{
			for(var i = 0; i < array_length(engine().win_screen_order); i++)
				{
				var _data = engine().win_screen_order[@ i];
				if (_data[@ WIN_SCREEN_DATA.player_number] == player_number)
					{
					array_delete(engine().win_screen_order, i, 1);
					log("Removed player number (", player_number, ") from the win screen order!");
					return true;
					}
				}
			return false;
			}
		}
	else
		{
		crash("[player_win_order_remove] The given instance is not an instance of obj_player! (", object_get_name(_inst.object_index), ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */