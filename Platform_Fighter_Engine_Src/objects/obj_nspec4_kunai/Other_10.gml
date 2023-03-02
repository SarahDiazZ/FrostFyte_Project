//VFX
if ((destroy && array_length(hitbox_group_array) == 0) || lifetime <= 0)
	{
	var _move_angle = point_direction(0, 0, hsp, vsp);
	with(owner)
		{
		vfx_create_color(spr_nspec4_kunai_hit_normal, 1, 0, 20, other.x, other.y, 1, _move_angle + 45, "VFX_Layer_Below");
		}
	}
	
event_inherited();
/* Copyright 2023 Springroll Games / Yosi */