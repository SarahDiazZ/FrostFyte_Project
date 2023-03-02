///@category Hitboxes
///@param {id} hitbox			The hitbox to change the owner of
///@param {id} new_owner		The instance id of the new object that will be the owner
/*
Changes the owner of the specified hitbox to the specified instance.
Please note: The new owner instance must have the following variable:
	- player_id
*/
function hitbox_owner_change() {
	with(argument[0])
		{
		var _id = argument[1];
		assert(instance_exists(_id), "[hitbox_owner_change] The provided instance does not exist (", _id, ")");
		owner = _id;
		player_id = _id.player_id;
		}
}
/* Copyright 2023 Springroll Games / Yosi */