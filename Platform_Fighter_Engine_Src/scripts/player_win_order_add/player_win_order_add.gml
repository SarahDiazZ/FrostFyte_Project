///@category Player Engine Scripts
///@param {bool} is_winner		Whether the player won the match or not
///@param {id} [player]			The instance id of the player to add to the win screen order
/*
Adds the given player to the win screen order. If no player is specified, the calling <obj_player> will add itself.
*/
function player_win_order_add() {
	var _winner = argument[0];
	var _inst = argument_count > 1 ? argument[1] : id;
	if (_inst == noone) then _inst = id;
	
	if (object_is(_inst.object_index, obj_player))
		{
		with(_inst)
			{
			//Make sure you aren't already added
			for(var i = 0; i < array_length(engine().win_screen_order); i++)
				{
				var _data = engine().win_screen_order[@ i];
				if (_data[@ WIN_SCREEN_DATA.player_number] == player_number)
					{
					log("The player (", player_number, ") is already in the win screen order!");
					return false;
					}
				}
				
			//Add the data
			var _data = [];
			_data[@ WIN_SCREEN_DATA.is_winner] = _winner;
			_data[@ WIN_SCREEN_DATA.character] = character;
			_data[@ WIN_SCREEN_DATA.color] = player_color
			_data[@ WIN_SCREEN_DATA.player_number] = player_number;
			_data[@ WIN_SCREEN_DATA.player_name] = player_name;
			_data[@ WIN_SCREEN_DATA.team] = player_team;
			array_push(engine().win_screen_order, _data);
			log("Added player ", player_number, " to the win screen order!");
			return true;
			}
		}
	else
		{
		crash("[player_win_order_add] The given instance is not an instance of obj_player! (", object_get_name(_inst.object_index), ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */