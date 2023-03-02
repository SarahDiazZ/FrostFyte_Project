///@category Hitboxes
///@param {int} group_number		The group number to move
///@param {int} x					The x position
///@param {int} y					The y position
///@param {bool} [absolute]			Whether to move the hitboxes to the absolute position or to the relative position
///@param {array} [my_hitboxes]		The hitbox array to use
/*
Moves all hitboxes within the given group relative to their current positions.
If the absolute argument is true, the hitboxes will be moved to the absolue x and y coordinates given.
*/
function hitbox_move_attached_group() {
	//Loop through all hitbox instances
	var _group = argument[0];
	var _x = argument[1];
	var _y = argument[2];
	var _abs = argument_count > 3 ? argument[3] : false;
	var _array = argument_count > 4 ? argument[4] : my_hitboxes;
	
	for(var i = 0; i < array_length(_array); i++)
		{
		var _hitbox = _array[@ i];
		if (_hitbox.hitbox_group == _group)
			{
			with(_hitbox)
				{
				if (!_abs) 
					{
					x += _x;
					y += _y;
					owner_xstart -= _x;
					owner_ystart -= _y;
					}
				else
					{
					x = _x;
					y = _y;
					xstart = _x;
					ystart = _y;
					owner_xstart = owner.x;
					owner_ystart = owner.y;
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */