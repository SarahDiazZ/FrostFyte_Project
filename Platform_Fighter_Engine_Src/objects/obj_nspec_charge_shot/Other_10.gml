///@description
if (lifetime % 3 == 0 && abs(hsp) > 1)
	{
	var _vfx = vfx_create(spr_projectile_trail_large, 1, 0, 8, x, y, overlay_scale, 1, "VFX_Layer_Below");
	_vfx.vfx_xscale = sign(hsp) * overlay_scale * 2;
	_vfx.vfx_yscale = prng_choose(0, -1, 1) * overlay_scale;
	_vfx.vfx_blend = palette_color_get(owner.palette_data, 0);
	}
	
//VFX
if ((destroy && array_length(hitbox_group_array) == 0) || lifetime <= 0)
	{
	vfx_create(spr_hit_electric, 1, 0, 26, x, y, clamp(overlay_scale, 0.5, 1.5), prng_number(0, 360));
	camera_shake(overlay_scale * 2);
	}
	
event_inherited();
/* Copyright 2023 Springroll Games / Yosi */