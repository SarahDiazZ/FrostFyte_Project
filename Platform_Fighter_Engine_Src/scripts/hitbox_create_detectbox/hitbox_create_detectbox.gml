///@category Hitboxes
///@param {int} rel_x						The relative x from the calling player
///@param {int} rel_y						The relative y from the calling player
///@param {real} xscale						The horizontal size scaling. At a scaling of 1, hitboxes are 64 pixels wide
///@param {real} yscale						The vertical size scaling. At a scaling of 1, hitboxes are 64 pixels tall
///@param {int} lifetime					How many frames the hitbox will last
///@param {int/asset} shape					The shape of the hitbox, either a property of the SHAPE enum or a sprite asset
///@param {int} hitbox_group				The hitbox group number. By default, this must be a number from 0 to 3
///@param {asset} [detect_script]			A script to run when the detectbox hits a hurtbox. If no script is given, the detectbox runs the attack's PHASE.detection
/*
Creates a new <obj_hitbox_detectbox> and returns the instance id.
*/
function hitbox_create_detectbox() {
	assert(argument_count >= 7, "[hitbox_create_detectbox] Wrong number of arguments! (", argument_count, ")");
	var _newhitbox = instance_create_layer(round(x + argument[0] * facing), round(y + argument[1]), layer, obj_hitbox_detectbox);
	with(_newhitbox)
		{
		image_xscale = argument[2];
		image_yscale = argument[3];
		lifetime = argument[4];
		hitbox_shape_set(_newhitbox, argument[5]);
		owner = other.id;
		player_id = other.player_id;
		owner_xstart = other.x;
		owner_ystart = other.y;
		hitbox_group = argument[6];
		facing = other.facing;
		detect_script = argument_count > 7 ? argument[7] : -1;
		}
	array_push(my_hitboxes, _newhitbox);
	return _newhitbox;
}
/* Copyright 2023 Springroll Games / Yosi */