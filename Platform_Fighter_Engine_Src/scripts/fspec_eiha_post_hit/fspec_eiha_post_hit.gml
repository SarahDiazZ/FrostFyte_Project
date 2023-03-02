function fspec_eiha_post_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	//Apply poison status effect
	if (_hitbox.has_hit && !_hitbox.has_been_blocked)
		{
		if (object_is(_hurtbox.owner.object_index, obj_player))
			{
			with(_hurtbox.owner)
				{
				callback_remove(callback_passive, poison_passive);
				callback_add(callback_passive, poison_passive, CALLBACK_TYPE.permanent);
				
				//6 ticks of damage because the passive script does damage every 30 frames
				custom_passive_struct.poison_frame = ((6 - 1) * 30) + 1;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */