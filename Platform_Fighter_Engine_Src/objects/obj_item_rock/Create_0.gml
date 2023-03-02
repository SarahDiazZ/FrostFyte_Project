GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.throwing;
_s.item_actions = item_rock_actions;

var _ids = custom_ids_struct;
_ids.hitbox = noone;
_ids.hurtbox = noone;
/* Copyright 2023 Springroll Games / Yosi */