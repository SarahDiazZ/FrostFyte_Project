///@description

//Hitlag
if (self_hitlag_frame > 0)
	{
	self_hitlag_frame -= 1;
	exit;
	}

var _c = custom_entity_struct;

_c.lifetime -= 1;

if (_c.lifetime <= 0)
	{
	//VFX
	var _vfx = vfx_create_color(spr_nspec_hadoken_fizzle, 1, 0, 14, x, y, 2, 0, "VFX_Layer");
	_vfx.vfx_xscale = 2 * facing;
	_vfx.owner = owner;
	
	hitbox_destroy_attached_all();
	instance_destroy();
	exit;
	}

//Use a different collision mask
mask_index = spr_hitbox_circle;
image_xscale = 0.4;
image_yscale = 0.4;

//Heavy
if (_c.type == 1)
	{
	if (_c.phase == 1)
		{
		//Multihit
		if (_c.lifetime % 3 == 0)
			{
			hitbox_group_reset(1);
			hitbox_group_whitelist_id(owner, 1);
			}
	
		//Final hit
		if (_c.lifetime == 1)
			{
			var _hitbox = hitbox_create_melee(0, 0, 0.7, 0.7, 1, 8, 0.4, 3, 50, 1, SHAPE.circle, 2);
			_hitbox.hit_vfx_style = [HIT_VFX.magic, HIT_VFX.normal_strong];

			hitbox_group_whitelist_id(owner, 2);
			}
		}
	}
	
//EX
if (_c.type == 2)
	{
	if (_c.phase == 1)
		{
		//Multihit
		if (_c.lifetime % 2 == 0)
			{
			hitbox_group_reset(1);
			hitbox_group_whitelist_id(owner, 1);
			}
	
		//Final hit
		if (_c.lifetime == 1)
			{
			var _hitbox = hitbox_create_melee(0, 0, 0.7, 0.7, 4, 7, 0.9, 20, 35, 1, SHAPE.circle, 2);
			_hitbox.hit_vfx_style = [HIT_VFX.magic, HIT_VFX.explosion, HIT_VFX.normal_strong];

			hitbox_group_whitelist_id(owner, 2);
			}
		}
	}

//Speeds
x += round(hsp);

if (collision(x, y, [FLAG.solid]))
	{
	//VFX
	var _vfx = vfx_create_color(spr_nspec_hadoken_fizzle, 1, 0, 14, x, y, 2, 0, "VFX_Layer");
	_vfx.vfx_xscale = 2 * facing;
	_vfx.owner = owner;
	
	hitbox_destroy_attached_all();
	instance_destroy();
	exit;
	}

//Overlay Sprite
_c.overlay_frame = (_c.overlay_frame + _c.overlay_speed) % sprite_get_number(sprite_index);

image_index = _c.overlay_frame;

//Reset sprite size
image_xscale = 2 * facing;
image_yscale = 2;
/* Copyright 2023 Springroll Games / Yosi */