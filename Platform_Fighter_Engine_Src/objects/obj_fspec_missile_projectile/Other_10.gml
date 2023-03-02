///@description
var _s = custom_projectile_struct;
if (lifetime % 2 == 0)
	{
	var _vfx = vfx_create(spr_projectile_trail, 1, 0, 32, x, y, 2, prng_number(0, 360), "VFX_Layer_Below");
	_vfx.vfx_blend = palette_color_get(owner.palette_data, 0);
	}

//*Manual Turning
var _lx, _ly;
with(owner)
	{
	_lx = stick_get_value(Lstick, DIR.horizontal);
	_ly = stick_get_value(Lstick, DIR.vertical);
	}
if (point_distance(0, 0, _lx, _ly) > stick_tilt_amount)
	{
	var _newdir = point_direction(0, 0, _lx, _ly);
	var _turn_amount = clamp(angle_difference(_newdir, overlay_angle), -_s.turn_speed, _s.turn_speed);

	overlay_angle += _turn_amount;
	}
//*/

/*Automatic Turning
var _player = find_nearest_player(x, y, infinity, -1, true, [player_id]);
if (_player != noone)
	{
	overlay_angle += clamp(angle_difference(point_direction(x, y, _player.x, _player.y), overlay_angle), -_s.turn_speed, _s.turn_speed);
	}
//*/

hsp = lengthdir_x(_s.shoot_speed, overlay_angle);
vsp = lengthdir_y(_s.shoot_speed, overlay_angle);

event_inherited();
/* Copyright 2023 Springroll Games / Yosi */