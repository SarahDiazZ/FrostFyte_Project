///@category Player Actions
/*
Causes the player to fastfall.
*/
function fastfall() {
	//Fastfall
	speed_set(0, fastfall_speed, true, false);
	//VFX
	vfx_create(spr_shine_fastfall, 1, 0, 14, x + prng_number(0, 5, -5), y + prng_number(1, 5, -5), 2, 0);
}
/* Copyright 2023 Springroll Games / Yosi */