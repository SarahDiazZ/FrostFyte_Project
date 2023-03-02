///@category Hitboxes
///@param {int} rel_x						The relative x from the calling player
///@param {int} rel_y						The relative y from the calling player
///@param {real} xscale						The horizontal size scaling. At a scaling of 1, hitboxes are 64 pixels wide
///@param {real} yscale						The vertical size scaling. At a scaling of 1, hitboxes are 64 pixels tall
///@param {int} damage						The damage dealt by the hitbox
///@param {real} knockback					The base knockback of the hitbox
///@param {real} scaling					The knockback scaling
///@param {int} hitlag						The base number of frames the players freeze when the hitbox connects
///@param {real} angle						The base angle of the hitbox (assume the player is facing right)
///@param {int} lifetime					How many frames the hitbox will last
///@param {int/asset} shape					The shape of the hitbox, either a property of the SHAPE enum or a sprite asset
///@param {int} hitbox_group				The hitbox group number. By default, this must be a number from 0 to 3
///@param {int} [flipper]					The angle flipper the hitbox uses, from the FLIPPER enum
/*
Creates a new <obj_hitbox_melee> and returns the instance id.
*/
function hitbox_create_melee() {
	assert(argument_count >= 12, "[hitbox_create_melee] Wrong number of arguments! (", argument_count, ")");
	var _newhitbox = instance_create_layer(round(x + argument[0] * facing), round(y + argument[1]), layer, obj_hitbox_melee);
	with(_newhitbox)
		{
		image_xscale = argument[2];
		image_yscale = argument[3];
		damage = argument[4] * other.damage_attack_multiplier;
		if (damage_decimal_places == 0) then damage = ceil(damage);
		base_knockback = argument[5] * other.knockback_multiplier;
		knockback_scaling = argument[6];
		base_hitlag = argument[7];
		angle = argument[8];
		lifetime = argument[9];
		hitbox_shape_set(_newhitbox, argument[10]);
		owner = other.id;
		player_id = other.player_id;
		owner_xstart = other.x;
		owner_ystart = other.y;
		hitbox_group = argument[11];
		angle_flipper = (argument_count > 12 && !is_undefined(argument[12])) ? argument[12] : FLIPPER.standard;
		drawing_angle = owner.facing == -1 ? 180 - angle : angle;
		facing = other.facing;
		}
	array_push(my_hitboxes, _newhitbox);
	return _newhitbox;
}
/* Copyright 2023 Springroll Games / Yosi */