///@category Hitboxes
///@description
/*
A melee hitbox is a type of attached hitbox that deals standard damage and knockback.
Melee hitboxes are the most common type of hitboxes, and knockback from them is affected by DI, ASDI, teching, etc.
*/
image_blend = melee_draw_color;

GAME_STATE_OBJECT

event_inherited();

/*MELEE VARIBLES*/
damage = 10;
base_knockback = 10;
owner_xstart = 0; 
owner_ystart = 0;
angle = knockback_angle_default;
base_hitlag = 5;
hitlag_scaling = 1;
hitstun_scaling = 1;
custom_hitstun = -1;
knockback_scaling = 1;
angle_flipper = FLIPPER.standard;
di_angle = di_default;
drawing_angle = knockback_angle_default;
knockback_state = PLAYER_STATE.hitstun;
knockback_formula = KNOCKBACK_FORMULA.standard;
extra_hitlag = 0;
techable = true;
can_lock = false;
force_reeling = false;
asdi_multiplier = 1;
drift_di_multiplier = 1;
shieldstun_scaling = 1;
custom_shield_damage = -1;
background_clear_allow = true;
/* Copyright 2023 Springroll Games / Yosi */