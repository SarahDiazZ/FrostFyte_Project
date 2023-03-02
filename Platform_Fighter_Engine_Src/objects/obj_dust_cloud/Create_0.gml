///@category FX
/*
The dust clouds created by players launched at high speeds.
*/
///@description
GAME_STATE_OBJECT

event_inherited();

var _s = custom_vfx_struct;

_s.uni_c = shader_get_uniform(shd_dust_cloud, "color");
_s.uni_f = shader_get_uniform(shd_dust_cloud, "fade_amount");
_s.color = [0, 0, 0];
/* Copyright 2023 Springroll Games / Yosi */