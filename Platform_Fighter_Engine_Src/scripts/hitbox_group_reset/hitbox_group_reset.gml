///@category Hitboxes
///@param {int} group_number				The group number to clear
///@param {array} [hitbox_groups_array]		The array of hitbox groups
/*
Clears the given hitbox group for the calling player.
*/
function hitbox_group_reset() {
	//Clears a single hitbox group array
	var _groups = argument_count > 1 ? argument[1] : hitbox_groups;
	array_resize(_groups[@ argument[0]], 0);
}
/* Copyright 2023 Springroll Games / Yosi */