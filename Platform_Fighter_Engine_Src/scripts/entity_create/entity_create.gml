///@category Gameplay
///@param {real} x					The x position
///@param {real} y					The y position
///@param {asset} obj				What entity object to create
///@param {string/int} [layer]		The name or index of the layer to create the entity on
/*
Creates an instance of the given entity object at the given x and y, and returns the id.
If no layer is specified, it attempts to create the entity on a layer in the room with the name "Game_Layer".
This function must be used to create entity objects, otherwise they will not have their variables initialized properly.
*/
function entity_create() {
	var _x = argument[0];
	var _y = argument[1];
	var _obj = argument[2];
	var _layer = argument_count > 3 ? argument[3] : layer_get_id("Game_Layer");
	
	assert(object_is(_obj, obj_entity), "[entity_create] Cannot create a non-entity object with this function (", object_get_name(_obj), ")");
	
	var _entity = instance_create_layer(_x, _y, _layer, _obj);
	with(_entity)
		{
		owner = other.id;
		player_id = other.player_id;
		//Pass the owner's variables
		palette_base = owner.palette_base;
		palette_swap = owner.palette_swap;
		palette_data = owner.palette_data;
		player_color = owner.player_color;
		player_team = owner.player_team;
		}
	return _entity;
}
/* Copyright 2023 Springroll Games / Yosi */