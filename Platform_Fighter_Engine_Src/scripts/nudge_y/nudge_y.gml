///@category Collisions
///@param {int} dir					Either -1 for up, or 1 for down
///@param {bool} [drop_through]		If the player will drop through platforms or not
/*
Moves the player by 1 pixel either up or down, taking slopes into account.
If the drop_through argument is true, players can move through platforms downward.
*/
function nudge_y() {
	var _dir = argument[0];
	var _drop = argument_count > 1 ? argument[1] : false;
	
	if (_dir == -1)
		{
		if (!collision(x, y + _dir, [FLAG.solid]))
			{
			y += _dir;
			return true;
			}		
		else
			{
			if (move_against_slope_y(_dir))
				{
				//Successfully moved against the slope!
				return true;
				}
			else
				{
				return false;
				}
			}
		}
	else
		{
		if (!_drop)
			{
			if (on_ground())
				{
				return false;
				}
			else
				{
				y += _dir;
				return true;
				}
			}
		else
			{
			if (!on_solid())
				{
				y += _dir;
				return true;
				}
			else
				{
				return false;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */