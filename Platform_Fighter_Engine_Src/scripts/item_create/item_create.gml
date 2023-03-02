///@category Items
///@param {real} x					The x position
///@param {real} y					The y position
///@param {asset} obj				What item object to create
///@param {id} [player]				The player who owns the item
/*
Spawns an instance of the given item object at the given x and y, and returns the id.
If a player id is specified, then the item will be owned by that player.
*/
function item_create() {
	var _x = argument[0];
	var _y = argument[1];
	var _obj = argument[2];
	var _owner = argument_count > 3 ? argument[3] : noone;
	var _layer = layer_get_id("Game_Layer");
	
	assert(object_is(_obj, obj_item_parent), "[item_create] Cannot create a non-item object with this function (", object_get_name(_obj), ")");
	
	var _item = instance_create_layer(_x, _y, _layer, _obj);
	with(_item)
		{
		owner = _owner;
		if (owner != noone)
			{
			//Pass the owner's variables
			player_id = owner.player_id;
			palette_base = owner.palette_base;
			palette_swap = owner.palette_swap;
			palette_data = owner.palette_data;
			player_color = owner.player_color;
			player_team = owner.player_team;
			}
		}
	return _item;
}
/* Copyright 2023 Springroll Games / Yosi */