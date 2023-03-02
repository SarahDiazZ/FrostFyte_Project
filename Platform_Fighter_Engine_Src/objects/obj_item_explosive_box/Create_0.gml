GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.hazard;
_s.self_hitlag_frame = 0;
_s.exploding = false;

//Create the hurtbox
var _ids = custom_ids_struct;
_ids.hurtbox = hurtbox_create_permanent(sprite_index);
_ids.hurtbox.image_xscale = image_xscale;
_ids.hurtbox.image_yscale = image_yscale;
with(_ids.hurtbox)
	{
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	
	hurtbox_setup
		(
		item_explosive_box_hit,
		item_explosive_box_hit,
		-1,
		item_explosive_box_hit,
		item_explosive_box_detectbox_hit,
		-1,
		item_explosive_box_hit,
		);
	}

/* Copyright 2023 Springroll Games / Yosi */