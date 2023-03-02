///@category Hitboxes
/*
A grab hitbox is a type of attached hitbox that grabs opponents, changing them to the is_grabbed state and the attacking player to the grabbing state.
Grabs can only collide with one opponent, even if there are multiple overlapping opponents.
*/
image_blend = grab_draw_color;

GAME_STATE_OBJECT

event_inherited();

/*HITBOX VARIABLES*/
hit_vfx_style = HIT_VFX.grab;

/*GRAB VARIABLES*/
owner_xstart = 0; 
owner_ystart = 0;
grab_destination_x = x;
grab_destination_y = y;
/* Copyright 2023 Springroll Games / Yosi */