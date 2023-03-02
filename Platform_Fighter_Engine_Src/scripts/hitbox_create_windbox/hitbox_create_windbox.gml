///@category Hitboxes
///@param {int} rel_x						The relative x from the calling player
///@param {int} rel_y						The relative y from the calling player
///@param {real} xscale						The horizontal size scaling. At a scaling of 1, hitboxes are 64 pixels wide
///@param {real} yscale						The vertical size scaling. At a scaling of 1, hitboxes are 64 pixels tall
///@param {int} damage						The damage dealt by the hitbox
///@param {real} knockback					The base knockback of the hitbox
///@param {real} angle						The base angle of the hitbox (assume the player is facing right)
///@param {int} lifetime					How many frames the hitbox will last
///@param {int/asset} shape					The shape of the hitbox, either a property of the SHAPE enum or a sprite asset
///@param {int} hitbox_group				The hitbox group number. By default, this must be a number from 0 to 3
///@param {int} [flipper]					The angle flipper the hitbox uses, from the FLIPPER enum
///@param {bool} [multihit]					Whether the windbox can hit an opponent multiple times or not
///@param {bool} [accelerate]				Whether the windbox accelerates an opponent or directly changes their speed
///@param {bool} [push]						Whether the windbox pushes an opponent or simply sets their speed
///@param {real} [max_speed]				The maximum speed the windbox can give an opponent
///@param {bool} [lift]						Whether the windbox can lift opponents off the ground or not
/*
Creates a new <obj_hitbox_windbox> and returns the instance id.
*/
function hitbox_create_windbox() {
	assert(argument_count >= 10, "[hitbox_create_windbox] Wrong number of arguments! (", argument_count, ")");
	var _newhitbox = instance_create_layer(round(x + argument[0] * facing), round(y + argument[1]), layer, obj_hitbox_windbox);
	with(_newhitbox)
		{
		image_xscale = argument[2];
		image_yscale = argument[3];
		damage = argument[4] * other.damage_attack_multiplier;
		if (damage_decimal_places == 0) then damage = ceil(damage);
		base_knockback = argument[5] * other.knockback_multiplier;
		angle = argument[6];
		lifetime = argument[7];
		hitbox_shape_set(_newhitbox, argument[8]);
		owner = other.id;
		player_id = other.player_id;
		owner_xstart = other.x;
		owner_ystart = other.y;
		hitbox_group = argument[9];
		angle_flipper = (argument_count > 10 && !is_undefined(argument[10])) ? argument[10] : FLIPPER.standard;
		drawing_angle = owner.facing == -1 ? 180 - angle : angle;
		windbox_multihit = (argument_count > 11 && !is_undefined(argument[11])) ? argument[11] : false;
		windbox_accelerate = (argument_count > 12 && !is_undefined(argument[12])) ? argument[12] : true;
		windbox_push = (argument_count > 13 && !is_undefined(argument[13])) ? argument[13] : false;
		windbox_max_speed = (argument_count > 14 && !is_undefined(argument[14])) ? argument[14] : 5;
		windbox_lift = (argument_count > 15 && !is_undefined(argument[15])) ? argument[15] : false;
		facing = other.facing;
		}
	array_push(my_hitboxes, _newhitbox);
	return _newhitbox;
}

/* Copyright 2023 Springroll Games / Yosi */