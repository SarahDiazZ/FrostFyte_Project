///@category Hitboxes
/*
Sets up the necessary variables and data structures for an object to create and own hitboxes.
Some types of hitboxes may require extra variables to be initialized.
*/
function hitbox_owner_init() {
	state = PLAYER_STATE.attacking;

	//The id of the player who gets credit for a KO
	player_id = noone;

	//Hitbox groups array
	hitbox_groups = array_create(hitbox_groups_max, undefined);
	for(var i = 0; i < hitbox_groups_max; i++)
		{
		hitbox_groups[@ i] = [];
		}
	
	//My Hitboxes Array - Keeps track of all of the user's hitboxes
	my_hitboxes = [];
	
	any_hitbox_has_hit = false;
	any_hitbox_has_been_blocked = false;

	facing = 1;
	self_hitlag_frame = 0;

	palette_data = 
		{ 
		array : [c_white], 
		columns : 1, 
		colors_per_column : 1, 
		alphas : [1.0],
		};
	player_team = -1;
	
	//Hitbox multipliers
	damage_attack_multiplier = 1.0;
	knockback_multiplier = 1.0;
}
/* Copyright 2023 Springroll Games / Yosi */