function item_rock_post_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	var _rock = _hitbox.owner;

	//Bounce off opponents
	with(_rock)
		{
		if (any_hitbox_has_hit || any_hitbox_has_been_blocked)
			{
			hsp *= -0.5;
			vsp = -7;
			
			//Get rid of the hitbox
			with(_hitbox) instance_destroy();
			
			//Hitlag
			self_hitlag_frame = 10;
			
			//VFX
			for(var i = 0; i < 10; i++)
				{
				var _vfx = vfx_create
					(
					spr_item_rock_shards, 
					0, 
					prng_number(i % prng_channels, 3), 
					15, 
					x, 
					y, 
					2, 
					i * 36, 
					"VFX_Layer_Below",
					);
				_vfx.fade = true;
				var _len = prng_number((i + 1) % prng_channels, 3, 1);
				_vfx.hsp = lengthdir_x(_len, i * 36);
				_vfx.vsp = lengthdir_y(_len, i * 36);
				var _len = prng_number((i + 2) % prng_channels, 30, 10);
				_vfx.x += lengthdir_x(_len, i * 36);
				_vfx.y += lengthdir_y(_len, i * 36);
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */