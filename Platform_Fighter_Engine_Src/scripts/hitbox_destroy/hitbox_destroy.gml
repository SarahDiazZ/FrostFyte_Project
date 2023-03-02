///@category Hitboxes
///@param {id} hitbox_ids		The id(s) to be destroyed
/*
Destroys the hitboxes entered as arguments.
If any of the given ids are not hitbox objects, it will crash.
*/
function hitbox_destroy() {
	var _hitbox = noone;
	for(var i = 0; i < argument_count; i++)
		{
		_hitbox = argument[i];
		if (instance_exists(_hitbox))
			{
			if (object_is(_hitbox.object_index, obj_hitbox))
				{
				instance_destroy(_hitbox);
				}
			else
				{
				crash("[hitbox_destroy] The given ID is not a valid obj_hitbox instance ID! (", _hitbox, ")");
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */