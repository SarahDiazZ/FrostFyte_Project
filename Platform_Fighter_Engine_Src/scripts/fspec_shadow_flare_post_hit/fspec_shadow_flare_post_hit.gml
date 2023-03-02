function fspec_shadow_flare_post_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	var _num = _hitbox.custom_projectile_struct.shadow_flare_number;
	
	if (_hitbox.has_hit)
		{
		//Destroy existing shadow flare balls
		with(obj_fspec_shadow_flare_ball)
			{
			if (owner == _hitbox.owner && custom_ids_struct.target == _hurtbox.owner)
				{
				_num = min(_num + 1, 5);
				instance_destroy();
				}
			}

		//Create shadow flare balls
		var _dir = 0;
		var _inc = 360 / _num;
		for(var i = 0; i < _num; i++)
			{
			with(entity_create(_hurtbox.owner.x, _hurtbox.owner.y, obj_fspec_shadow_flare_ball, "VFX_Layer"))
				{
				custom_entity_struct.number = i;
				custom_entity_struct.dir = _dir;
				custom_entity_struct.phase = 0;
				custom_entity_struct.frame = 220;
				custom_ids_struct.target = _hurtbox.owner;
				image_xscale = choose(-2, 2);
				image_yscale = choose(-2, 2);
				}
			_dir += _inc;
			}
		}
}

/* Copyright 2023 Springroll Games / Yosi */