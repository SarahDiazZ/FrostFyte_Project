///@description
GAME_STATE_OBJECT

event_inherited();

hsp = 0;
vsp = 0;

var _s = custom_entity_struct;
var _ids = custom_ids_struct;

_s.max_fall_speed = 12;
_s.grav = 0.6;
_s.hp = 10;
_s.planted = false;
_s.launched = false;
_s.lifetime = 360;
_s.water_time = 0;
_s.angle = 0;
_s.palette_base = [0, 0, 0, 0];
_s.palette_swap = [0, 0, 0, 0];
_s.player_color = 0;

image_xscale = 2;
image_yscale = 2;
y = round(y);

//Drop hitbox object
_ids.drop_hitbox = hitbox_create_melee(0, 0, 0.5, 1, 8, 8, 1, 10, 45, 360, SHAPE.square, 0, FLIPPER.from_hitbox_center_horizontal);

//Launch hitbox object
_ids.launch_hitbox = noone;

//Water hitboxes
_ids.water_hitbox_right = noone;
_ids.water_hitbox_top = noone;
_ids.water_hitbox_left = noone;

//Hurtbox object
_ids.hurtbox = noone;

//Move out of blocks (max distance = 64 pixels)
var _f = [FLAG.solid];
var _moved_out = false;
for(var i = 0; (i < 64 && !_moved_out); i += 4)
	{
	for(var m = 0; m < 4; m++)
		{
		if (!collision(x + round(lengthdir_x(i, m * 90)), y + round(lengthdir_y(i, m * 90)), _f))
			{
			x += round(lengthdir_x(i, m * 90));
			y += round(lengthdir_y(i, m * 90));
			_moved_out = true;
			break;
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */