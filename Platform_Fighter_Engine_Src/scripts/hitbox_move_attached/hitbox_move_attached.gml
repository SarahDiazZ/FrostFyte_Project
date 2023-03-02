///@category Hitboxes
///@param {id} hitbox_id		The hitbox to move
///@param {int} x				The x position
///@param {int} y				The y position
///@param {bool} [absolute]		Whether to move the hitbox to the absolute position or to the relative position
/*
Moves an attached hitbox relative to its current position.
If the absolute argument is true, the hitbox will be moved to the absolue x and y coordinates given.

For example, if the hitbox is at x = 4, y = 10 and hitbox_move_attached(hitbox, 5, 5) is called, the hitbox will end up at x = 9, y = 15.
If hitbox_move_attached(hitbox, 5, 5, true) is called, the hitbox will end up at x = 5, y = 5.
*/
function hitbox_move_attached() {
	var _hitbox = argument[0];
	var _x = round(argument[1]);
	var _y = round(argument[2]);
	var _abs = argument_count > 3 ? argument[3] : false;
	
	//Target the hitbox
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
/* Copyright 2023 Springroll Games / Yosi */