function chip_damage_post_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];
	var _opponent = _hurtbox.owner;
	
	//Only works for hitbox types with a damage amount
	if (object_is(_hitbox.object_index, obj_hitbox_melee) ||
		object_is(_hitbox.object_index, obj_hitbox_targetbox) ||
		object_is(_hitbox.object_index, obj_hitbox_windbox) ||
		object_is(_hitbox.object_index, obj_hitbox_magnetbox) ||
		object_is(_hitbox.object_index, obj_hitbox_projectile))
		{
		if (_hitbox.has_been_blocked)
			{
			if (object_is(_opponent.object_index, obj_player))
				{
				apply_damage(_opponent, ceil(_hitbox.damage / 2));
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */