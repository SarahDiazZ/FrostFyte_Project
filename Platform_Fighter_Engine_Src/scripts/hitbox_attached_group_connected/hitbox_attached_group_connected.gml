///@category Hitboxes
///@param {int} group					The group number
///@param {bool} [count_blocked]		Whether to count blocked hits
///@param {bool} [only_blocked]			Whether to only count blocked hits
///@param {array} [my_hitboxes]			The hitbox array to use
/*
Returns true if any of the attached hitboxes in the given group have hit an opponent.
*/
function hitbox_attached_group_connected() {
	//Loop through all attached hitbox instances
	var _count_blocked = argument_count > 1 ? argument[1] : false;
	var _only_blocked = argument_count > 2 ? true : false;
	var _array = argument_count > 3 ? argument[3] : my_hitboxes;

	for(var i = 0; i < array_length(_array); i++)
		{
		var _hitbox = _array[@ i];
		if (_hitbox.hitbox_group == argument[0])
			{
			if (_count_blocked)
				{
				if (_only_blocked) then return _hitbox.has_been_blocked;
				else return _hitbox.has_hit || _hitbox.has_been_blocked;
				}
			else return _hitbox.has_hit;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */