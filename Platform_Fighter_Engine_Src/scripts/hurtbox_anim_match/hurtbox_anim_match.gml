///@category Hurtboxes
///@param {asset} [hurtbox_sprite]		The sprite to change the player's hurtbox to
/*
Changes the sprite of the permanent hurtbox of the calling player to match their current animation.
If a specific sprite is given, that sprite will be used instead, but the frame of the sprite will still be the frame of the player's current animation.
This function is inteded to be used during attacks to make sure the player's hurtbox matches the attack's animation.
*/
function hurtbox_anim_match() {
	var _sprite = argument_count > 0 ? argument[0] : anim_sprite;
	if (sprite_exists(_sprite))
		{
		hurtbox.sprite_index = _sprite;
		hurtbox.image_index = clamp(floor(anim_frame), 0, sprite_get_number(anim_sprite) - 1);
		hurtbox.image_xscale = sprite_scale * facing;
		hurtbox.image_yscale = sprite_scale;
		hurtbox.image_angle = anim_angle;
		}
}
/* Copyright 2023 Springroll Games / Yosi */