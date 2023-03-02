///@category Items
/*
If the calling item instance is currently held by a player, it will move to the player's location.
*/
function item_move_with_holder() {
	var _ids = custom_ids_struct;
	
	//If the item is being held
	if (_ids.item_holder != noone)
		{
		//Snap to the holder's location
		var _player = _ids.item_holder;
		x = _player.x + (_player.item_hold_x * _player.facing);
		y = _player.y + (_player.item_hold_y);
		}
}
/* Copyright 2023 Springroll Games / Yosi */