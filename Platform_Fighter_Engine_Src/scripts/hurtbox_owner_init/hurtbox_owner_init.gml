///@category Hurtboxes
/*
Sets up the necessary variables for an object to create and own hurtboxes.
*/
function hurtbox_owner_init() {
	//Initialize the fade value variable, so the game doesn't crash when <hit_vfx_style_create> is called.
	fade_value = 1;
	
	//Multipliers
	damage_taken_multiplier = 1.0;
}
/* Copyright 2023 Springroll Games / Yosi */