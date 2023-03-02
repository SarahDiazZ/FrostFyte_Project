///@category Hitboxes
/*
The parent object of all hitboxes, which are objects that can hit hurtboxes.
Similarly to hurtboxes, hitboxes are always owned by another instance - either an <obj_player> or an <obj_entity>.
obj_hitbox has two child objects - <obj_hitbox_attached> and <obj_hitbox_detached>.
This object and its direct children should never be created, as they are only used to categorize different hitbox types and can't actually hit anything.
*/

GAME_STATE_OBJECT

sync_id_assign();

/*GENERAL HITBOX VARIBLES*/
lifetime = 10;
owner = noone;
player_id = noone;
hitbox_group = 0;
facing = 1;
has_hit = false;
has_been_blocked = false;
can_be_parried = true;
check_first = false;
hit_vfx_style = HIT_VFX.normal_weak;
hit_sfx = hit_sound_default;
hit_restriction = HIT_RESTRICTION.none;
pre_hit_script = -1;
post_hit_script = -1;
hurtbox_hit_list = ds_list_create();
destroy = false;

/*OVERLAY VARIABLES*/
overlay_sprite = -1;
overlay_frame = 0;
overlay_speed = 1;
overlay_scale = 2;
overlay_angle = 0;
overlay_color = c_white;
overlay_alpha = 1.0;
overlay_facing = 1;

//Make sure hitboxes have integer coordinates
assert(frac(x) == 0 && frac(y) == 0, "[obj_hitbox: Create] Hitboxes MUST have integer coordinates! (", x, ", ", y, ")");
/* Copyright 2023 Springroll Games / Yosi */