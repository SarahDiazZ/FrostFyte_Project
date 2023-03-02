///@category Items
/*
This is the parent object for all items in the game.
Use <item_create> to spawn items during gameplay.
Please note: You can only pick up items with an ITEM_TYPE of:
	- melee_weapon
	- projectile_weapon
	- throwing
	- immediate_use
*/
GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Item variables
var _s = custom_entity_struct;
var _ids = custom_ids_struct;
_s.item_type = ITEM_TYPE.none;
_s.item_pickup_range = 72;
_s.item_thrown = false;
_s.item_actions = -1;
_s.lifetime = 600;
_ids.item_holder = noone;

image_xscale = item_sprite_scale_default;
image_yscale = image_xscale;
/* Copyright 2023 Springroll Games / Yosi */