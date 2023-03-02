///@description
var _s = custom_projectile_struct;

if (lifetime % 2 == 0)
	{
	var _vfx = vfx_create(spr_projectile_trail, 1, 0, 32, x, y, 2, prng_number(0, 360), "VFX_Layer_Below");
	_vfx.vfx_blend = palette_color_get(owner.palette_data, 0);
	}

event_inherited();

//Follow instructions
if (_s.current<= array_length(_s.instructions) - 1)
	{
	var _dir = _s.instructions[_s.current];
	hsp = lengthdir_x(10, _dir);
	vsp = lengthdir_y(10, _dir);
	overlay_angle = _dir;
	}
_s.timer += 1;
if (_s.timer > 10)
	{
	_s.timer = 0;
	_s.current += 1;
	if (_s.current > array_length(_s.instructions) - 1)
		{
		instance_destroy();
		exit;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */