///@category Hurtboxes
/*
Hurtboxes are objects that can be hit by hitboxes and run specific code during these interactions.
Similarly to hitboxes, hurtboxes are always owned by another instance - either an <obj_player> or an <obj_entity>.
There are 3 types of hurtboxes:
	- Permanent : Always stays with the owner instances, has an infinite lifetime.
	- Attack : Only exists during an attack, has a set lifetime and will also be destroyed instantly if the owner stops attacking.
	- Shield : Used for the "perfect_shield_start" / "parry_shield" shield types when shield poking is enabled.
*/
image_blend = hurtbox_draw_color;
image_speed = 0;
image_alpha = 0.5;

GAME_STATE_OBJECT

sync_id_assign();

/*GENERAL HURTBOX VARIABLES*/
owner = noone;
owner_xstart = 0;
owner_ystart = 0;
hurtbox_type = HURTBOX_TYPE.attack;
default_sprite = spr_hurtbox_default;
lifetime = 10;
check_first = true;
destroy = false;
inv_type = INV.normal;
inv_frame = 0;
inv_override = true;

/*HIT SCRIPTS*/
hurtbox_setup
	(
	hurtbox_melee_hit_player,
	hurtbox_magnetbox_hit_player,
	hurtbox_grab_hit_player,
	hurtbox_targetbox_hit_player,
	hurtbox_detectbox_hit_player,
	hurtbox_windbox_hit_player,
	hurtbox_projectile_hit_player,
	);
/* Copyright 2023 Springroll Games / Yosi */