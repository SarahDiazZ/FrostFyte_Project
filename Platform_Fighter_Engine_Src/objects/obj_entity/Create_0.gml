///@category Gameplay
/*
Entities are special objects that can be spawned by players.
They can create their own hitboxes and hurtboxes, use palette shaders, and can run custom update code from User Event 0.
The player that owns the entity is stored in the instance variable "owner".
Custom variables must be properties of the "custom_entity_struct", and custom variables that store instance ids must be properties of the "custom_ids_struct".
*/
GAME_STATE_OBJECT

sync_id_assign();

event_inherited();

//Passed from the player in <entity_create>
palette_base = [0, 0, 0, 0];
palette_swap = [0, 0, 0, 0];
player_color = 0;

//When created, the player will pass their ID
owner = noone;
player_id = noone;

//Default collision flags
collision_flag_set(id, FLAG.ride, true);
collision_flag_set(id, FLAG.push, true);

//Allow the entity to spawn hitboxes
hitbox_owner_init();

//Allow the entity to spawn hurtboxes
hurtbox_owner_init();

//Custom Entity Variables
custom_entity_struct = {};
custom_ids_struct = {};
/* Copyright 2023 Springroll Games / Yosi */