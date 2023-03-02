///@description <Run by obj_game>
//Move
x += hsp;
y += vsp;

//Frame increase, except for the first frame
if (lifetime != total_life)
	{
	vfx_frame += vfx_speed * sprite_get_speed(vfx_sprite) / (sprite_get_speed_type(vfx_sprite) == spritespeed_framespergameframe ? 1 : room_speed);
	}
if (vfx_frame > sprite_get_number(vfx_sprite))
	{
	vfx_frame -= sprite_get_number(vfx_sprite);
	}
	
//Following
if (instance_exists(follow))
	{
	follow_offset_x -= hsp;
	follow_offset_y -= vsp;
	
	x = follow.x + follow_offset_x;
	y = follow.y + follow_offset_y;
	}
	
//Shrinking
if (shrink != 0)
	{
	vfx_xscale *= shrink;
	vfx_yscale *= shrink;
	}
	
//Spinning
vfx_angle += spin;

//Lifetime / Performance Mode
if (--lifetime < 0 || (setting().performance_mode && !important))
	{
	instance_destroy();
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */