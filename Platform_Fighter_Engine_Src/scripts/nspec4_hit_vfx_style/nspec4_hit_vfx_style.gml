function nspec4_hit_vfx_style() {
	var _angle = argument[0];
	var _hitbox = argument[1];
	var _knock = argument[2];
	var _layer = argument[3];
	
	//Creating the VFX
	var _vfx = noone;
	var _move_angle = point_direction(0, 0, _hitbox.hsp, _hitbox.vsp);
	if (_hitbox.damage == 1)
		{
		_vfx = vfx_create_color(spr_nspec4_kunai_hit_normal, 1, 0, 20, x, y, 2, _move_angle + 45, _layer);
		}
	else if (_hitbox.damage == 2)
		{
		_vfx = vfx_create_color(spr_nspec4_kunai_hit_hitstun, 1, 0, 20, x, y, 2, _move_angle + 45, _layer);
		}
	else
		{
		_vfx = vfx_create_color(spr_nspec4_kunai_hit_counter, 1, 0, 20, x, y, 2, _move_angle + 45, _layer);
		}
		
	//VFX properties
	_vfx.owner = _hitbox.owner.player_id;
	if (prng_number(0, 1) == 0)
		{
		_vfx.vfx_yscale *= -1;
		_vfx.vfx_angle -= 90
		}
}
/* Copyright 2023 Springroll Games / Yosi */