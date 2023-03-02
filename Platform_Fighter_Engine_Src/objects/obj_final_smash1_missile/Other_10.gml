///@description
custom_entity_struct.lifetime -= 1;
var _life = custom_entity_struct.lifetime;

//Smoke trail
if (_life % 4 == 0)
	{
	var _vfx = vfx_create(spr_dust_cloud1, 1, 0, 18, x, y, 1, image_angle, "VFX_Layer_Below");
	_vfx.vfx_yscale = prng_choose(0, -1, 1);
	}

//Move to the top
if (_life >= 25 && y > obj_stage_manager.blastzones.top - 128)
	{
	x += lengthdir_x(15, custom_entity_struct.dir);
	y += lengthdir_y(15, custom_entity_struct.dir);
	image_angle = custom_entity_struct.dir;
	}
//Attack players
else if (_life < 25)
	{
	var _xprev = x;
	var _yprev = y;
	x = lerp(x, custom_ids_struct.target.x, 0.1);
	y = lerp(y, custom_ids_struct.target.y, 0.1);
	if (x != custom_ids_struct.target.x || y != custom_ids_struct.target.y)
		{
		image_angle = point_direction(_xprev, _yprev, x, y);
		}
	}
	
//Hitbox
if (_life == 2)
	{
	x = custom_ids_struct.target.x;
	y = custom_ids_struct.target.y;
	
	var _hitbox = hitbox_create_melee(0, 0, 1, 1, 10, 5, 0.8, 10, 90, 1, SHAPE.circle, 0);
	hitbox_group_whitelist_id(owner, 0);
	_hitbox.hit_vfx_style = [HIT_VFX.electric, HIT_VFX.explosion, HIT_VFX.lines, HIT_VFX.normal_strong];
	_hitbox.hit_sfx = snd_hit_explosion3;
	_hitbox.custom_hitstun = 30;
	}

if (_life == 1)
	{
	image_alpha = 1;
	}
	
//Destroy if the target player is knocked out
if (is_knocked_out(custom_ids_struct.target))
	{
	_life = 0;
	}

//Lifetime
if (_life <= 0)
	{
	if (!attack_connected())
		{
		vfx_create(spr_hit_explosion, 1, 0, 18, x, y, 1, 45, "VFX_Layer_Below");
		game_sound_play(snd_hit_explosion2);
		}
	instance_destroy();
	}
/* Copyright 2023 Springroll Games / Yosi */