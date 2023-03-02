///@category Gameplay
///@param {id} new_owner		The instance id of the new object that will be the owner
/*
Changes the owner of the calling entity to the specified instance.
Please note: The new owner instance must have the following variables:
	- player_id
	- player_color
	- player_team
	- palette_base
	- palette_swap
	- palette_data
*/
function entity_owner_change() {
	var _id = argument[0];
	assert(instance_exists(_id), "[entity_owner_change] The provided instance does not exist (", _id, ")");
	owner = _id;
	player_id = _id.player_id;
	player_color = _id.player_color;
	player_team = _id.player_team;
	palette_base = _id.palette_base;
	palette_swap = _id.palette_swap;
	palette_data = _id.palette_data;
}
/* Copyright 2023 Springroll Games / Yosi */