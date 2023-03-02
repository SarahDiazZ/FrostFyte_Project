///@description

//Held item visibility
var _player = custom_ids_struct.item_holder;
if (_player != noone && instance_exists(_player))
	{
	if (!_player.item_visible) then exit;
	}

if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	image_angle = custom_entity_struct.angle;
	item_draw_self();
	image_angle = 0;
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */