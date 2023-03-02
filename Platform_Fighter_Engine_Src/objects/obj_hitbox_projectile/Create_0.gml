///@category Hitboxes
/*
A projectile hitbox is a type of detached hitbox that deals standard damage and knockback.
Projectiles differ from attached hitboxes in many ways, including:
	- They are not destroyed when the player is not in the attacking state
	- They do not give the attacking player hitlag
	- They use individual hitbox groups
	- They use the palette shader when drawn
Any custom projectile variables must be properties of the "custom_projectile_struct".
*/
image_blend = projectile_draw_color;

GAME_STATE_OBJECT

event_inherited();

/*PROJECTILE VARIBLES*/
visible = true;
damage = 10;
base_knockback = 10;
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
techable = true;
can_lock = false;
force_reeling = false;
asdi_multiplier = 1;
drift_di_multiplier = 1;
shieldstun_scaling = 1;
custom_shield_damage = -1;
background_clear_allow = true;
self_hitlag_frame = 0;
hsp = 0;
vsp = 0;
fric = 0;
grav = 0;
hbounce = false;
vbounce = false;
bounce_multiplier = 1.0;
destroy_on_blocks = false;
pass_through_blocks = false;
destroy_outside_room = true;
destroy_on_hit = true;
destroy = false;
hitbox_group_array = [];
custom_projectile_struct = {};
/* Copyright 2023 Springroll Games / Yosi */