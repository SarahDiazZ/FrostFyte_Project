///@category Player Actions
///@param {real} [direction]		The direction to throw the item
/*
Throws the item the player is currently holding, and returns the id of the item that was thrown.
The direction should be from 0-360 for a normal throw, and -1 for an item drop.
If a direction is specified, the player's "item_throw_direction" variable will be set to that direction.
Please note: You can only pick up and hold items with an ITEM_TYPE of:
	- melee
	- projectile
	- throwing
	- immediate_use
*/
function throw_item() {
	//Direction
	if (argument_count > 0) then item_throw_direction = argument[0];
	
	var _item = item_held;
	if (_item != noone && instance_exists(_item))
		{
		item_held = noone;
		with(_item)
			{
			var _s = custom_entity_struct;
			var _ids = custom_ids_struct;
			_s.item_thrown = true;
					
			//Move the item out of blocks
			move_out_of_blocks(361);
				
			//Run the item script with the throw action, if it exists
			if (_s.item_actions != -1 && script_exists(_s.item_actions))
				{
				script_execute(_s.item_actions, ITEM_ACTION.thrown);
				}
					
			//The item is no longer being held
			_ids.item_holder = noone;
			}
				
		//VFX
		vfx_create(spr_shine_attack, 1, 0, 8, x, y, 1, 41);
			
		return _item;
		}
		
	//No item was thrown
	return noone;
}
/* Copyright 2023 Springroll Games / Yosi */