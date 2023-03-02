///@category Hitboxes
///@param {id} id						The hitbox to check
///@param {bool} [count_blocked]		Whether to count blocked hits
///@param {bool} [only_blocked]			Whether to only count blocked hits
/*
Returns true if the given hitbox has hit an opponent.
Please note: This function does not check if the given id is actually a hitbox instance!
*/
function hitbox_connected() {
	//Find the hitbox
	var _count_blocked = argument_count > 1 ? argument[1] : false;
	var _only_blocked = argument_count > 2 ? true : false;

	if (instance_exists(argument[0]))
		{
		if (_count_blocked)
			{
			if (_only_blocked) then return argument[0].has_been_blocked;
			else return argument[0].has_hit || argument[0].has_been_blocked;
			}
		else return argument[0].has_hit;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */