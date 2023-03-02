///@category Hitboxes
///@param {int} rel_x					The relative x from the calling player
///@param {int} rel_y					The relative y from the calling player
///@param {real} xscale					The horizontal size scaling. At a scaling of 1, hitboxes are 64 pixels wide
///@param {real} yscale					The vertical size scaling. At a scaling of 1, hitboxes are 64 pixels tall
///@param {int} xhold					The relative x to hold the grabbed player at
///@param {int} yhold					The relative y to hold the grabbed player at
///@param {int} lifetime				How many frames the hitbox will last
///@param {int/asset} shape				The shape of the hitbox, either a property of the SHAPE enum or a sprite asset
/*
Creates a new <obj_hitbox_grab> and returns the instance id.
*/
function hitbox_create_grab() {
	assert(argument_count == 8, "[hitbox_create_grab] Wrong number of arguments! (", argument_count, ")");
	var _newhitbox = instance_create_layer(round(x + argument[0] * facing), round(y + argument[1]), layer, obj_hitbox_grab);
	with(_newhitbox)
		{
		image_xscale = argument[2];
		image_yscale = argument[3];
		grab_destination_x = argument[4];
		grab_destination_y = argument[5];
		lifetime = argument[6];
		hitbox_shape_set(id, argument[7]);
		owner = other.id;
		player_id = other.player_id;
		owner_xstart = other.x;
		owner_ystart = other.y;
		facing = other.facing;
		}
	array_push(my_hitboxes, _newhitbox);
	return _newhitbox;
}
/* Copyright 2023 Springroll Games / Yosi */