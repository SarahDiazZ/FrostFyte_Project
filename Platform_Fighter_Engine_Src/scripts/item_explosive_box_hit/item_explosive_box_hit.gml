function item_explosive_box_hit() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	var _s = custom_entity_struct;
	
	//It can only be hit if it's not already exploding
	if (!_s.exploding)
		{
		//Register the hit
		hitbox_register_hit(_hitbox);
	
		//Hitlag
		_s.self_hitlag_frame = 15;
		_hitbox.owner.self_hitlag_frame = 20;
	
		//Effects
		hit_vfx_style_create(HIT_VFX.normal_strong, 90, _hitbox, 15);
		hit_sfx_play(snd_hit_strong3);
	
		//Only explode if some time has passed already
		if (_s.lifetime < 540)
			{
			_s.exploding = true;
			_s.lifetime = 5;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */