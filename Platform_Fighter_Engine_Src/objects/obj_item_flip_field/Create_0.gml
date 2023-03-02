GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.hazard;
_s.flip = false;
_s.flip_timer = 0;

collision_flag_set(id, FLAG.ride, false);

image_index = 0;
image_speed = 0;

//Create the hurtbox
var _ids = custom_ids_struct;
_ids.hurtbox = hurtbox_create_permanent(sprite_index);
with(_ids.hurtbox)
	{
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	
	hurtbox_setup
		(
		item_flip_field_hit,
		item_flip_field_hit,
		-1,
		item_flip_field_hit,
		-1,
		-1,
		item_flip_field_hit,
		);
	}

/* Copyright 2023 Springroll Games / Yosi */