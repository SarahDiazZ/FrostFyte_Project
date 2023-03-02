function item_bat_post_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	var _ball = _hitbox.owner;

	//Bounce off opponents
	with(_ball)
		{
		if (any_hitbox_has_hit || any_hitbox_has_been_blocked)
			{
			hsp *= -0.25;
			vsp = -4;
			
			//Get rid of the hitbox
			with(_hitbox) instance_destroy();
			
			//Hitlag
			self_hitlag_frame = 5;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */