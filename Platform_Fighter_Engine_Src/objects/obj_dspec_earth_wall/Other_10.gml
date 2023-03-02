var _s = custom_entity_struct;
var _ids = custom_ids_struct;

self_hitlag_frame -= 1;
if (self_hitlag_frame > 0) then exit;

//Attack
_s.lifetime -= 1;
if (_s.lifetime == 118)
	{
	//Second hitbox
	image_index = 1;
	
	var _hitbox = hitbox_create_melee(12, -64, 0.6, 1.2, 5, 7, 1.0, 5, 75, 3, SHAPE.square, 0);
	_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
	_hitbox.hit_sfx = snd_hit_strong;
	}
else if (_s.lifetime == 116)
	image_index = 2;
else if (_s.lifetime == 114)
	image_index = 3;
else if (_s.lifetime == 112)
	image_index = 4;
else if (_s.lifetime == 110)
	image_index = 5;
else if (_s.lifetime == 108)
	image_index = 6;
else if (_s.lifetime == 16)
	image_index = 7;
else if (_s.lifetime == 12)
	image_index = 8;
else if (_s.lifetime == 8)
	image_index = 9;
else if (_s.lifetime == 4)
	image_index = 10;

//Destroy
if (_s.lifetime <= 0)
	{
	instance_destroy();
	}
else if (y > room_height)
	{
	instance_destroy();
	}
/* Copyright 2023 Springroll Games / Yosi */