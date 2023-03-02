///@category Hitboxes
///@param {int} group_number		The group number
///@param {array} [my_hitboxes]		The hitbox array to use
/*
Destroys all of the hitboxes in the given hitbox group.
*/
function hitbox_destroy_group() {
	var _array = argument_count > 1 ? argument[1] : my_hitboxes;
	for(var i = 0; i < array_length(_array); i++)
		{
		var _hitbox = _array[@ i];
		if (_hitbox.hitbox_group == argument[0])
			{
			//Instances remove themselves from the list automatically if they are deleted
			instance_destroy(_hitbox);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */