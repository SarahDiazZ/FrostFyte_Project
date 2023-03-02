///@category Gameplay
/*
Checks if any player (or team) has won the game, and sets up the win screen accordingly.
Please note: This can only be run from <obj_game>.
*/
function game_win_conditions() {
	assert(object_is(object_index, obj_game), "[game_win_conditions] You can only run this script from obj_game");

	var _should_end = false;
	var _num_players = ds_list_size(ordered_player_list);
	
	//Singleplayer mode does not check any win conditions, you need to manually implement them!
	if (engine().singleplayer_mode) then return false;
	
	//Stock Matches
	if (match_has_stock_set())
		{
		//Free for alls
		if (!setting().match_team_mode)
			{
			//Check how many players are left
			var _players_left = [];
			for(var i = 0; i < _num_players; i++)
				{
				with(ordered_player_list[| i])
					{
					if (state != PLAYER_STATE.lost)
						{
						array_push(_players_left, id);
						}
					}
				}
				
			var _num_left = array_length(_players_left);
			if (_num_left == 1)
				{
				//One player wins
				player_win_order_add(true, _players_left[@ 0]);
				_should_end = true;
				}
			else if (_num_left > 1)
				{
				//No player has won yet
				}
			else
				{
				//Find all of the players who were put in the Lost state on the most recent frame
				var _players_lost = [];
				var _lost_time_min = infinity;
				for(var i = 0; i < _num_players; i++)
					{
					with(ordered_player_list[| i])
						{
						if (state == PLAYER_STATE.lost)
							{
							if (state_time < _lost_time_min)
								{
								_players_lost = [];
								_lost_time_min = state_time;
								}
							if (state_time == _lost_time_min)
								{
								array_push(_players_lost, id);
								}
							}
						}
					}
				
				//Player with least damage / most stamina wins
				//Yes there is port priority
				var _min_damage_player = _players_lost[@ 0];
				for(var i = 1; i < array_length(_players_lost); i++)
					{
					with(_players_lost[@ i])
						{
						if (match_has_stamina_set())
							{
							if (stamina >= _min_damage_player.stamina)
								{
								_min_damage_player = id;
								}
							}
						else
							{
							if (damage <= _min_damage_player.damage)
								{
								_min_damage_player = id;
								}
							}
						}
					}
				player_win_order_remove(_min_damage_player);
				player_win_order_add(true, _min_damage_player);
				_should_end = true;
				}
			}
		//Team modes
		else
			{
			//Check how many teams are left
			var _teams_left = [];
			for(var i = 0; i < _num_players; i++)
				{
				with(ordered_player_list[| i])
					{
					if (state != PLAYER_STATE.lost)
						{
						if (!array_contains(_teams_left, player_team))
							{
							array_push(_teams_left, player_team);
							}
						}
					}
				}
			var _num_left = array_length(_teams_left);
			if (_num_left == 1)
				{
				//One team wins
				var _winning_team = _teams_left[@ 0];
				for(var i = 0; i < _num_players; i++)
					{
					with(ordered_player_list[| i])
						{
						if (player_team == _winning_team)
							{
							player_win_order_remove();
							player_win_order_add(true);
							}
						}
					}
				engine().win_screen_team = _winning_team;
				_should_end = true;
				}
			else if (_num_left > 1)
				{
				//No team has won yet
				}
			else
				{
				//Find all of the players who were put in the Lost state on the most recent frame
				var _players_lost = [];
				var _lost_time_min = infinity;
				for(var i = 0; i < _num_players; i++)
					{
					with(ordered_player_list[| i])
						{
						if (state == PLAYER_STATE.lost)
							{
							if (state_time < _lost_time_min)
								{
								_players_lost = [];
								_lost_time_min = state_time;
								}
							if (state_time == _lost_time_min)
								{
								array_push(_players_lost, id);
								}
							}
						}
					}

				//The team of the player with least damage / most stamina wins
				//Yes there is port priority
				var _min_damage_player = _players_lost[@ 0];
				for(var i = 1; i < array_length(_players_lost); i++)
					{
					with(_players_lost[@ i])
						{
						if (match_has_stamina_set())
							{
							if (stamina >= _min_damage_player.stamina)
								{
								_min_damage_player = id;
								}
							}
						else
							{
							if (damage <= _min_damage_player.damage)
								{
								_min_damage_player = id;
								}
							}
						}
					}
				var _winning_team = _players_lost[@ _min_damage_player].player_team;
				for(var i = 0; i < _num_players; i++)
					{
					with(ordered_player_list[| i])
						{
						if (player_team == _winning_team)
							{
							player_win_order_remove();
							player_win_order_add(true);
							}
						}
					}
				engine().win_screen_team = _winning_team;
				_should_end = true;
				}
			}
		}
		
	//Time Matches
	if (match_has_time_set())
		{
		if (game_time >= (setting().match_time * 60 * 60))
			{
			//Free for alls
			if (!setting().match_team_mode)
				{
				//Find the players with the highest score
				//Also add all players to the win order at this point
				//The calculated winner will be removed and added again later
				var _highest_score = -infinity;
				var _player_list = [];
				for(var i = 0; i < _num_players; i++)
					{
					with(ordered_player_list[| i])
						{
						var _score = player_calculate_score();
						if (_score > _highest_score)
							{
							_highest_score = _score;
							_player_list = [];
							}
						if (_score >= _highest_score)
							{
							array_push(_player_list, id);
							}
						player_win_order_add(false);
						}
					}
					
				var _num_left = array_length(_player_list);
				if (_num_left == 1)
					{
					//One player wins
					player_win_order_remove(_player_list[@ 0]);
					player_win_order_add(true, _player_list[@ 0]);
					}
				else if (_num_left > 1)
					{
					//Randomly choose a winner
					var _winner = prng_number(0, _num_left - 1);
					player_win_order_remove(_player_list[@ _winner]);
					player_win_order_add(true, _player_list[@ _winner]);
					}
				else
					{
					crash("[game_win_conditions] Invalid number of players with the highest score (", _num_left, ")");
					}
				}
			//Team modes
			else
				{
				//Find the team with the highest combined score
				var _team_scores = array_create(max_teams, 0);
				for(var i = 0; i < _num_players; i++)
					{
					with(ordered_player_list[| i])
						{
						_team_scores[@ player_team] += player_calculate_score();
						player_win_order_add(false);
						}
					}
				var _highest_score = -infinity;
				var _team_list = [];
				for(var i = 0; i < max_teams; i++)
					{
					if (_team_scores[@ i] > _highest_score)
						{
						_highest_score = _team_scores[@ i];
						_team_list = [];
						}
					if (_team_scores[@ i] >= _highest_score)
						{
						array_push(_team_list, i);
						}
					}
					
				var _winning_team = -1;
				var _num_left = array_length(_team_list);
				if (_num_left == 1)
					{
					//One team wins
					_winning_team = _team_list[@ 0];
					}
				else if (_num_left > 1)
					{
					//Randomly choose a winner
					_winning_team = prng_number(0, _num_left - 1);
					}
				else
					{
					crash("[game_win_conditions] Invalid number of teams with the highest score (", _num_left, ")");
					}
					
				//Remove and add all of the winning players
				for(var i = 0; i < _num_players; i++)
					{
					with(ordered_player_list[| i])
						{
						if (player_team == _winning_team)
							{
							player_win_order_remove();
							player_win_order_add(true);
							}
						}
					}
				engine().win_screen_team = _winning_team;
				}
				
			//Always end the game
			_should_end = true;
			}
		}
	
	//End the game is needed
	if (_should_end)
		{
		state = GAME_STATE.ending;
		game_end_frame = game_end_time;
		return true;
		}
}
/* Copyright 2023 Springroll Games / Yosi */