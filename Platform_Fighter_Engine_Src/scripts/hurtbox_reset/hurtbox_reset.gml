///@category Hurtboxes
/*
Resets a player's permanent hurtbox to the default sprite.
*/
function hurtbox_reset() {
	hurtbox.sprite_index = hurtbox.default_sprite;
	hurtbox.image_index = 0;
	hurtbox.image_xscale = 1;
	hurtbox.image_yscale = 1;
	hurtbox.image_angle = 0;
}
/* Copyright 2023 Springroll Games / Yosi */