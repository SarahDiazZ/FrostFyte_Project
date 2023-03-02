///@category FX
/*
obj_vfx is the parent object of all visual effects objects.
Use <vfx_create> to create it.
If you want to create a visual effect that uses the palette shader, use <vfx_create_color> instead.
*/
///@description
GAME_STATE_OBJECT

sync_id_assign();

//Variables
lifetime = 10;
follow = noone;
follow_offset_x = 0;
follow_offset_y = 0;
shrink = 1;
fade = false;
spin = 0;
hsp = 0;
vsp = 0;
vfx_sprite = spr_hit_normal_weak;
vfx_frame = 0;
vfx_speed = 0;
vfx_xscale = 1;
vfx_yscale = 1;
vfx_angle = 0;
vfx_blend = c_white;
vfx_alpha = 1;
total_life = lifetime;
vfx_allow_fade = true;
owner = noone;
important = false; //Important VFX will not be turned off when performance mode is on
custom_vfx_struct = {};
/* Copyright 2023 Springroll Games / Yosi */