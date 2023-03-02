///@category Player Actions
///@param {real} [x]					The x position to measure distance from
///@param {real} [y]					The y position to measure distance from
///@param {real} [max_distance]			The maximum distance to search
///@param {int} [team]					The team the calling instance is on
///@param {bool} [team_attack]			Whether to target teammates if team attack is enabled for the match
///@param {array} [ignored_ids]			Any players that should be ignored
/*
Returns the id of the nearest player instance to the calling instance's coordinates, or the specified coordinates. Players that are out of the match are not counted. Players will not return their own id.
If the "team" argument is given and team mode is enabled with team attack off, then players with the same team number are not counted.
If the "team_attack" argument is false, then teammates will not be targetted even if team attack is on.
You can optionally supply an array of player ids to be ignored by this function.
*/
function find_nearest_player() {
	var _x = argument_count > 0 ? argument[0] : x;
	var _y = argument_count > 1 ? argument[1] : y;
	var _max_dist = argument_count > 2 ? argument[2] : infinity;
	var _team = argument_count > 3 ? argument[3] : -1;
	var _team_attack = argument_count > 4 ? argument[4] : true;
	var _ignore = argument_count > 5 ? argument[5] : [];
	var _nearest_id = noone;
	var _nearest_distance = _max_dist;
	
	with(obj_player)
		{
		//If the calling object is a player, it cannot count itself
		if (id == other.id) then continue;
		
		//Make sure the other player isn't dead
		if (is_knocked_out()) then continue;
		
		//Check teams
		if (setting().match_team_mode && (!setting().match_team_attack || !_team_attack) && _team == player_team) then continue;
		
		//Calculate distance
		var _dist = point_distance(_x, _y, x, y);
		if (_dist > _max_dist) then continue;
		
		//Check against the distance of other players
		if (_dist <= _nearest_distance)
			{
			//Ignoring
			if (!array_contains(_ignore, id))
				{
				_nearest_distance = _dist;
				_nearest_id = id;
				}
			}
		}
	
	//Return the id
	return _nearest_id;
}
/* Copyright 2023 Springroll Games / Yosi */