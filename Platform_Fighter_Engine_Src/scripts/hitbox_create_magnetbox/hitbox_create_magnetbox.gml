///@category Hitboxes
///@param {int} rel_x						The relative x from the calling player
///@param {int} rel_y						The relative y from the calling player
///@param {real} xscale						The horizontal size scaling. At a scaling of 1, hitboxes are 64 pixels wide
///@param {real} yscale						The vertical size scaling. At a scaling of 1, hitboxes are 64 pixels tall
///@param {int} damage						The damage dealt by the hitbox
///@param {int} hitlag						The base number of frames the players freeze when the hitbox connects
///@param {int} goal_x						The relative x opponents will be moved towards on hit
///@param {int} goal_y						The relative y opponents will be moved towards on hit
///@param {int} magnet_time					How many freams opponents will be magnetized on hit
///@param {int} lifetime					How many frames the hitbox will last
///@param {int/asset} shape					The shape of the hitbox, either a property of the SHAPE enum or a sprite asset
///@param {int} hitbox_group				The hitbox group number. By default, this must be a number from 0 to 3
///@param {bool} [relative]					Whether the magnetbox goal coordinates will be relative to the player (true) or to the hitbox (false)
/*
Creates a new <obj_hitbox_magnetbox> and returns the instance id.
*/
function hitbox_create_magnetbox() {
	assert(argument_count >= 12, "[hitbox_create_magnetbox] Wrong number of arguments! (", argument_count, ")");
	var _newhitbox = instance_create_layer(round(x + argument[0] * facing), round(y + argument[1]), layer, obj_hitbox_magnetbox);
	with(_newhitbox)
		{
		image_xscale = argument[2];
		image_yscale = argument[3];
		damage = argument[4] * other.damage_attack_multiplier;
		if (damage_decimal_places == 0) then damage = ceil(damage);
		base_hitlag = argument[5];
		magnet_goal_x = round(argument[6] * other.facing);
		magnet_goal_y = round(argument[7]);
		state_frame = argument[8];
		lifetime = argument[9];
		hitbox_shape_set(id, argument[10]);
		owner = other.id;
		player_id = other.player_id;
		owner_xstart = other.x;
		owner_ystart = other.y;
		hitbox_group = argument[11];
		magnet_relative = (argument_count > 12 && !is_undefined(argument[12])) ? argument[12] : false;
		facing = other.facing;
		}
	array_push(my_hitboxes, _newhitbox);
	return _newhitbox;
}
/* Copyright 2023 Springroll Games / Yosi */