///@category Hitboxes
/*
A detectbox is a type of attached hitbox that activates custom code when first colliding with a hurtbox.
By default, detectboxes will run the PHASE.detection of the player's current attack, however, a "detect_script" can be assigned to the detectbox to be run instead.
The following arguments are passed to the attack script / detect script:
	- The id of the detected hurtbox's owner
	- The id of the detectbox
You can set the "detect_multihit" variable to allow a detectbox to hit players multiple times without having to manually reset hitbox groups every frame.
*/
image_blend = detectbox_draw_color;

GAME_STATE_OBJECT

event_inherited();

/*DETECTBOX VARIBLES*/
owner_xstart = 0;
owner_ystart = 0;
detect_script = -1;
detect_multihit = false;
/* Copyright 2023 Springroll Games / Yosi */