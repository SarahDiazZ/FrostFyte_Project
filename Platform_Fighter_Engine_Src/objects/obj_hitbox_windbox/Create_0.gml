///@category Hitboxes
/*
A windbox is a type of attached hitbox that pushes opponents around.
Windboxes have many unique settings, such as hitting multiple times, what type of push logic to use, and if they can lift players off the ground or not.
*/
image_blend = windbox_draw_color;

GAME_STATE_OBJECT

event_inherited();

/*WINDBOX VARIABLES*/
windbox_multihit = false; //If the windbox can hit the same person multiple times
windbox_accelerate = true; //If the windbox applies a speed boost or an instant speed set
windbox_push = false; //If set to true, the windbox will not change the opponent's speed and will instead move them directly
windbox_max_speed = 5; //The maximum speed the windbox can boost the opponent to
windbox_lift = false; //If the windbox can lift players off the ground

/*MELEE VARIBLES*/
damage = 0;
base_knockback = 10;
owner_xstart = 0;
owner_ystart = 0;
angle = knockback_angle_default;
knockback_scaling = 0;
angle_flipper = FLIPPER.standard;
di_angle = di_default;
drawing_angle = knockback_angle_default;
extra_hitlag = 0;
hit_vfx_style = -1;
hit_sfx = -1;
shieldstun_scaling = 1;
/* Copyright 2023 Springroll Games / Yosi */