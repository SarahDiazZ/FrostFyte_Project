///@category Hitboxes
///@param {id} hitbox						The hitbox to register a hit for
///@param {bool} [blocked]					Whether the hit has been blocked or not
///@param {bool} [attached]					Whether the hitbox is an attached hitbox or not
///@param {bool} [add_to_hitbox_group]		Whether the hit player will be added to the hitbox group of the attacking player or not
/*
Registers either a hit or a block for a given hitbox.
If the hitbox is an attached hitbox, then the owner of the hitbox will also register a hit or block.
This script must be run from the player or entity that is being hit.
By default, the id of the hit player will be added to the hitbox group of the attacking player.
*/
function hitbox_register_hit() {
	var _hitbox = argument[0];
	var _blocked = argument_count > 1 ? argument[1] : false;
	var _attached = argument_count > 2 ? argument[2] : object_is(_hitbox.object_index, obj_hitbox_attached);
	var _add_to_hitbox_group = argument_count > 3 ? argument[3] : true;

	if (_attached)
		{
		if (!_blocked)
			{
			//Mark the hitbox as having hit something
			_hitbox.has_hit = true;
			_hitbox.owner.any_hitbox_has_hit = true;
		
			//The hit will count toward KO points in a Time match with infinite stock
			ko_property = _hitbox.player_id;
			}
		else
			{
			//Mark the hitbox as having been blocked
			_hitbox.has_been_blocked = true;
			_hitbox.owner.any_hitbox_has_been_blocked = true;
			}

		//Add the hit player to the hitbox group array of the attacking player
		if (_add_to_hitbox_group)
			{
			array_push(_hitbox.owner.hitbox_groups[@ _hitbox.hitbox_group], id);
			}
		}
	else
		{
		if (!_blocked)
			{
			//Mark the hitbox as having hit something
			_hitbox.has_hit = true;
			
			//The hit will count toward KO points in a Time match with infinite stock
			ko_property = _hitbox.player_id;
			}
		else
			{
			//Mark the hitbox as having been blocked
			_hitbox.has_been_blocked = true;
			}
			
		//Add the hit player to the hitbox group array of the detached hitbox
		if (_add_to_hitbox_group)
			{
			array_push(_hitbox.hitbox_group_array, id);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */