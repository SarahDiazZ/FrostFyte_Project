///@description
//Reduced stun
base_hitlag = max(base_hitlag - 2, 0);
base_knockback = max(base_knockback - 0.1, 0);
var _vfx = vfx_create(spr_projectile_trail, 1, 0, 32, x, y, 2, prng_number(0, 360), "VFX_Layer_Below");
_vfx.vfx_blend = palette_color_get(owner.palette_data, 0);
event_inherited();
/* Copyright 2023 Springroll Games / Yosi */