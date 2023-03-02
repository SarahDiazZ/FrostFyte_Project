GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.throwing;
_s.item_actions = item_ball_actions;

var _ids = custom_ids_struct;
_ids.hitbox = noone;
_ids.hurtbox = hurtbox_create_permanent(sprite_index);
with(_ids.hurtbox)
	{
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	
	hurtbox_setup
		(
		item_ball_hit,
		item_ball_hit,
		-1,
		item_ball_hit,
		-1,
		-1,
		item_ball_hit,
		);
	}
/* Copyright 2023 Springroll Games / Yosi */