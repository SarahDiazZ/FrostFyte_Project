///@category Hitboxes
/*
A magnetbox is a type of attached hitbox that moves opponents to a predetermined position relative to the attacking player.
For example, a magnetbox with a magnet_goal_x of 30 will move opponents toward the hitbox's x + 30 on hit.
While magnetboxes are not always guaranteed to move players to the goal position due to blocks, interruptions, etc., they are useful for making multihit attacks that are more consistent than using Melee hitboxes.
Magnetboxes are not affected by DI or teching.
*/
image_blend = magnetbox_draw_color;

GAME_STATE_OBJECT

event_inherited();

/*MAGNETBOX VARIBLES*/
damage = 10;
owner_xstart = 0;
owner_ystart = 0;
base_hitlag = 5;
hitlag_scaling = 1;
drawing_angle = knockback_angle_default;
magnet_goal_x = 0;
magnet_goal_y = 0;
magnet_snap_speed = magnetbox_snap_speed_default;
state_frame = 0;
magnet_relative = false;
can_lock = false;
shieldstun_scaling = 1;
custom_shield_damage = -1;
/* Copyright 2023 Springroll Games / Yosi */