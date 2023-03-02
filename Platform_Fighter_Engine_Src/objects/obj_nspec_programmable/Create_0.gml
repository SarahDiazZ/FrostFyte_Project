///@description
GAME_STATE_OBJECT

event_inherited();

overlay_sprite = spr_fspec_missile_projectile;
overlay_speed = 0.3;

//Custom vars
var _s = custom_projectile_struct;
_s.instructions = [];
_s.current = 0;
_s.timer = 0;
/* Copyright 2023 Springroll Games / Yosi */