///@description Step

if (!custom_entity_struct.frozen)
	{
	//Gravity
	vsp = min(vsp + 0.5, 8);

	//Moving
	var _prev_hsp = hsp;
	var _prev_vsp = vsp;
	var _result = entity_move_simple(hsp, vsp, false, true, 0.7, false);
	hsp = _result.hsp;
	vsp = _result.vsp;
	
	//Special bouncing
	if (sign(_prev_vsp) > sign(vsp))
		{
		if (vsp > -8) then vsp = -8;
		var _vfx = vfx_create(spr_uspec4_log_spawn, 1, 0, 26, x, (bbox_bottom - 1), 2, 0, "VFX_Layer_Below");
		_vfx.vfx_xscale = choose(-2, 2);
		}
	if (sign(_prev_hsp) != sign(hsp))
		{
		hsp = sign(hsp) * 2;
		}
	}
	
var _destroy = false;

//Lifetime
custom_entity_struct.lifetime -= 1;
if (custom_entity_struct.lifetime == 0)
	{
	_destroy = true;
	}
	
//Blastzones
if (blastzones_check(false))
	{
	_destroy = true;
	}
	
if (_destroy)
	{
	//Poof VFX
	var _vfx = vfx_create(spr_dust_poof, 1, 0, 28, x, y, 2, 0, "VFX_Layer_Below");
	_vfx.vfx_xscale *= prng_choose(0, -1, 1);
	_vfx.vfx_yscale *= prng_choose(1, -1, 1);
	instance_destroy();
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */