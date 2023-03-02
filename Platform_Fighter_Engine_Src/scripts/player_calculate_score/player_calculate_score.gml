///@category Player Engine Scripts
///@param {id} [player]		The player to calculate the score for
/*
Calculates the "score" of the given player, to determine the winner in a Timed Match when the timer runs out.
The formula is different depending if Stock or Stamina are enabled.
*/
function player_calculate_score() {
	var _id = argument_count > 0 ? argument[0] : id;
	assert(object_is(_id.object_index, obj_player), "[player_calculate_score] The given id is not a player object (", object_get_name(_id.object_index), ")");
	with(_id)
		{
		var _score;
		var _health;
		if (match_has_stamina_set())
			{
			_health = damage_max - stamina;
			}
		else
			{
			_health = damage;
			}
		if (match_has_stock_set())
			{
			_score = (stock * (damage_max + 1)) + (damage_max - _health);
			}
		else
			{
			_score = (points * (damage_max + 1)) + (damage_max - _health);
			}
		return _score;
		}
}
/* Copyright 2023 Springroll Games / Yosi */