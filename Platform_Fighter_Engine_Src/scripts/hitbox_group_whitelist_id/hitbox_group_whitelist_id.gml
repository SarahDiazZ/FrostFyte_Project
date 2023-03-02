///@category Hitboxes
///@param {id} id							The id to whitelist
///@param {int} group_number				The hitbox group
///@param {array} [hitbox_groups_array]		The array of hitbox groups
/*
Adds the given id to the desired hitbox group, which means that id cannot be hit by hitboxes belonging to that group until the group is reset.
*/
function hitbox_group_whitelist_id() {
	var _id = argument[0];
	var _group = argument[1];
	var _array = argument_count > 2 ? argument[2] : hitbox_groups;
	
	array_push(_array[@ _group], _id);
}
/* Copyright 2023 Springroll Games / Yosi */