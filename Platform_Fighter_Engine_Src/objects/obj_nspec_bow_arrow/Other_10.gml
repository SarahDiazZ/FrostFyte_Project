///@description
with(owner)
	{
	if (other.lifetime % 2 == 0)
		{
		var _vfx = vfx_create_color(other.overlay_sprite, 0, 0, 10, other.x, other.y, 2, other.overlay_angle, "VFX_Layer_Below");
		_vfx.fade = true;
		}
	}
//Change angle
overlay_angle = point_direction(0, 0, hsp, vsp);

event_inherited();
/* Copyright 2023 Springroll Games / Yosi */