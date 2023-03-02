GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

//Variables
var _s = custom_entity_struct;
_s.item_type = ITEM_TYPE.hazard;
_s.hp = 30;

var _ids = custom_ids_struct;
_ids.hurtbox = hurtbox_create_permanent(sprite_index);
with(_ids.hurtbox)
	{
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	
	hurtbox_setup
		(
		item_final_smash_ball_hit,
		item_final_smash_ball_hit,
		-1,
		item_final_smash_ball_hit,
		-1,
		-1,
		item_final_smash_ball_hit,
		);
	}
	
//There can only be one Final Smash Ball
if (instance_number(obj_item_final_smash_ball) > 1)
	{
	instance_destroy();
	exit;
	}
	
//Destroy if a player already has a Final Smash
with(obj_player)
	{
	if (final_smash_uses > 0)
		{
		instance_destroy(other.id);
		exit;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */