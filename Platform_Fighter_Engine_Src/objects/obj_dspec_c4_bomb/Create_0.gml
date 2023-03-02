///@description
GAME_STATE_OBJECT

//Inherit the parent event
event_inherited();

vsp = 0;

var _s = custom_entity_struct;
var _ids = custom_ids_struct;

_s.grav = 0.5;
_s.max_fall_speed = 9;
_ids.attached = noone;
_s.grounded = false;
_s.explosion_time = -1;
_s.auto_explode_timer = 480;

image_speed = 0
image_xscale = 2;
image_yscale = 2;
/* Copyright 2023 Springroll Games / Yosi */