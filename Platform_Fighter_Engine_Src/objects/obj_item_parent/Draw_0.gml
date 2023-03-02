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
	
	item_draw_self();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */