///@category Hitboxes
///@param {asset} object					The object to create
///@param {int} rel_x						The relative x from the calling player
///@param {int} rel_y						The relative y from the calling player
///@param {real} xscale						The horizontal size scaling. At a scaling of 1, hitboxes are 64 pixels wide
///@param {real} yscale						The vertical size scaling. At a scaling of 1, hitboxes are 64 pixels tall
///@param {int} damage						The damage dealt by the hitbox
///@param {real} knockback					The base knockback of the hitbox
///@param {real} scaling					The knockback scaling
///@param {real} angle						The base angle of the hitbox (assume the player is facing right)
///@param {int} lifetime					How many frames the hitbox will last
///@param {int/asset} shape					The shape of the hitbox, either a property of the SHAPE enum or a sprite asset
///@param {int} hsp							The horizontal speed of the projectile
///@param {int} vsp							The vertical speed of the projectile
///@param {int} [flipper]					The angle flipper the hitbox uses, from the FLIPPER enum
/*
Creates a new object and initializes it as a projectile, then returns the instance id.
The given object should be a child of <obj_hitbox_projectile>.
*/
function hitbox_create_projectile_custom() {
	assert(argument_count >= 13, "[hitbox_create_projectile_custom] Wrong number of arguments! (", argument_count, ")");
	var _newhitbox = instance_create_layer(round(x + argument[1] * facing), round(y + argument[2]), layer, argument[0]);
	with(_newhitbox)
		{
		image_xscale = argument[3];
		image_yscale = argument[4];
		damage = argument[5] * other.damage_attack_multiplier;
		if (damage_decimal_places == 0) then damage = ceil(damage);
		base_knockback = argument[6] * other.knockback_multiplier;
		knockback_scaling = argument[7];
		angle = argument[8];
		lifetime = argument[9];
		hitbox_shape_set(id, argument[10]);
		owner = other.id;
		player_id = other.player_id;
		facing = other.facing;
		hsp = argument[11] * other.facing;
		vsp = argument[12];
		angle_flipper = argument_count > 13 ? argument[13] : FLIPPER.standard;
		drawing_angle = owner.facing == -1 ? 180 - angle : angle;
		}
	return _newhitbox;
}
/* Copyright 2023 Springroll Games / Yosi */