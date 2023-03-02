//Phases
var _target = custom_ids_struct.target;
var _phase = custom_entity_struct.phase;
var _frame = custom_entity_struct.frame;
var _num = custom_entity_struct.number;

if (!instance_exists(_target) || _target == noone)
	{
	instance_destroy();
	exit;
	}

if (_phase == 0)
	{
	var _dir = custom_entity_struct.dir + (_frame * 3);
	var _len = 50;
	x = round(_target.x + lengthdir_x(_len, _dir));
	y = round(_target.y + lengthdir_y(_len, _dir));
	custom_entity_struct.frame = _frame - 1;
	if (custom_entity_struct.frame <= 0)
		{
		custom_entity_struct.phase = 1;
		custom_entity_struct.frame = 30;
		}
	}
else
	{
	var _dir = custom_entity_struct.dir;
	var _len = lerp(0, 55, custom_entity_struct.frame / 30);
	x = round(_target.x + lengthdir_x(_len, _dir));
	y = round(_target.y + lengthdir_y(_len, _dir));
	custom_entity_struct.frame = _frame - 1;
	//Hitbox
	if (custom_entity_struct.frame == (3 + (_num * 5)))
		{
		if (owner.x != _target.x)
			{
			facing = sign(_target.x - owner.x);
			}
		var _hitbox = hitbox_create_melee(0, 0, 0.4, 0.4, 1, 3, 1, 10, 65, 3, SHAPE.circle, 0);
		_hitbox.hit_vfx_style = [HIT_VFX.magic, HIT_VFX.normal_medium];
		_hitbox.shieldstun_scaling = 0;
		hitbox_group_whitelist_id(owner, 0);
		}
	else if (custom_entity_struct.frame <= 0)
		{
		instance_destroy();
		exit;
		}
	}
	
//Animation
image_index += 0.5;

/* Copyright 2023 Springroll Games / Yosi */