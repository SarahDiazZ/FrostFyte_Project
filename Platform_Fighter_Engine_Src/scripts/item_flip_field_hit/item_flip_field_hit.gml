function item_flip_field_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	var _s = custom_entity_struct;
	if (_s.flip_timer == 0)
		{
		//Register the hit
		hitbox_register_hit(_hitbox);
	
		//Hitlag
		_hitbox.owner.self_hitlag_frame = 5;
	
		//Increase the lifetime slightly
		_s.lifetime = min(_s.lifetime + 60, 600);
	
		//Effects
		vfx_create(spr_hit_explosion, 1, 0, 18, x, y, 1, 0, "VFX_Layer_Below");
		hit_sfx_play(snd_hit_weak);
		camera_shake(4);
	
		//Set the variables
		_s.flip ^= 1;
		_s.flip_timer = 120;
		
		//Move when hit by a hitbox with a knockback angle
		if (object_is(_hitbox.object_index, obj_hitbox_melee) ||
			object_is(_hitbox.object_index, obj_hitbox_windbox) ||
			object_is(_hitbox.object_index, obj_hitbox_projectile))
			{
			var _len = 20;
			var _calc_angle = apply_angle_flipper(_hitbox.angle, _hitbox.angle_flipper, _hitbox.owner, id, _len, _hitbox.facing);
			hsp = lengthdir_x(_len, _calc_angle);
			vsp = lengthdir_y(_len, _calc_angle);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */