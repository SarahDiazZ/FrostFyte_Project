///@category Collisions
///@param {real} direction		The direction to try to move in
///@param {int} [dist]			The maximum distance the player can try to move
///@param {array} [flags]		What collision flags the player is trying to move out of, from the FLAG enum
/*
Attempts to move players out of blocks with the given collision flags. By default, players move out of solid blocks.
If the given direction is -1 or 361, the player will check 8 different directions to move out of blocks.
The player will stop checking possible positions to move to after the maximum distance is reached. By default, the maximum distance is 500 pixels.
*/
function move_out_of_blocks() {
	//Use the direction 361 or -1 to check 8 possible directions
	var _d = argument[0];
	var _l = argument_count > 1 ? argument[1] : 500;
	var _f = argument_count > 2 ? argument[2] : [FLAG.solid];

	if (!collision(x, y, _f)) then return false;

	if (_d != 361 && _d != -1)
		{
		for(var i = 0; i < _l; i++)
			{
			if (!collision(x + round(lengthdir_x(i, _d)), y + round(lengthdir_y(i, _d)), _f))
				{
				x += round(lengthdir_x(i, _d));
				y += round(lengthdir_y(i, _d));
				return true;
				}
			}
		}
	else
		{
		for(var i = 0; i < _l; i++)
			{
			for(var m = 0; m < 8; m++)
				{
				if (!collision(x + round(lengthdir_x(i, m * 45)), y + round(lengthdir_y(i, m * 45)), _f))
					{
					x += round(lengthdir_x(i, m * 45));
					y += round(lengthdir_y(i, m * 45));
					return true;
					}
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */