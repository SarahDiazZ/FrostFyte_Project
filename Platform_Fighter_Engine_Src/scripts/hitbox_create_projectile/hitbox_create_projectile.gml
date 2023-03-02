///@category Hitboxes
///@param {int} rel_x						The relative x from the calling player
///@param {int} rel_y						The relative y from the calling player
///@param {real} xscale						The horizontal size scaling. At a scaling of 1, hitboxes are 64 pixels wide
///@param {real} yscale						The vertical size scaling.At a scaling of 1, hitboxes are 64 pixels tall
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
Creates a new <obj_hitbox_projectile> and returns the instance id.
*/
function hitbox_create_projectile() {
	assert(argument_count >= 12, "[hitbox_create_projectile] Wrong number of arguments! (", argument_count, ")");
	var _newhitbox = instance_create_layer(round(x + argument[0] * facing), round(y + argument[1]), layer, obj_hitbox_projectile);
	with(_newhitbox)
		{
		image_xscale = argument[2];
		image_yscale = argument[3];
		damage = argument[4] * other.damage_attack_multiplier;
		if (damage_decimal_places == 0) then damage = ceil(damage);
		base_knockback = argument[5] * other.knockback_multiplier;
		knockback_scaling = argument[6];
		angle = argument[7];
		lifetime = argument[8];
		hitbox_shape_set(id, argument[9]);
		owner = other.id;
		player_id = other.player_id;
		facing = other.facing;
		hsp = argument[10] * other.facing;
		vsp = argument[11];
		angle_flipper = (argument_count > 12 && !is_undefined(argument[12])) ? argument[12] : FLIPPER.standard;
		drawing_angle = owner.facing == -1 ? 180 - angle : angle;
		}
	return _newhitbox;
}
/* Copyright 2023 Springroll Games / Yosi */