///@category Hurtboxes
///@param {asset} melee				The on-hit script to use for melee hitboxes
///@param {asset} magnetbox			The on-hit script to use for magnetboxes
///@param {asset} grab				The on-hit script to use for grab hitboxes
///@param {asset} targetbox			The on-hit script to use for targetboxes
///@param {asset} detectbox			The on-hit script to use for detectboxes
///@param {asset} windbox			The on-hit script to use for windboxes
///@param {asset} projectile		The on-hit script to use for projectiles
///@desc Sets up the on-hit scripts of a hurtbox for each type of hitbox
/*
Sets the on-hit scripts for the calling hurtbox.
*/
function hurtbox_setup() {
	if (script_exists(argument[0])) then melee_hit = argument[0];
	else melee_hit = hurtbox_hit_script_template;
	if (script_exists(argument[1])) then magnetbox_hit = argument[1];
	else magnetbox_hit = hurtbox_hit_script_template;
	if (script_exists(argument[2])) then grab_hit = argument[2];
	else grab_hit = hurtbox_hit_script_template;
	if (script_exists(argument[3])) then targetbox_hit = argument[3];
	else targetbox_hit = hurtbox_hit_script_template;
	if (script_exists(argument[4])) then detectbox_hit = argument[4];
	else detectbox_hit = hurtbox_hit_script_template;
	if (script_exists(argument[5])) then windbox_hit = argument[5];
	else windbox_hit = hurtbox_hit_script_template;
	if (script_exists(argument[6])) then projectile_hit = argument[6];
	else projectile_hit = hurtbox_hit_script_template;
}
/* Copyright 2023 Springroll Games / Yosi */