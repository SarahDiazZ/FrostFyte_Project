///@category Collisions
///@param {int} [x]			The x coordinate to check at
///@param {int} [y]			The y coordinate to check at
///@param {int} [vsp]		The player's current vertical speed
/*
Returns true if the player is standing on a platform.
This function normally checks the player's current position, but you can optionally give it specific coordinates to check.
Players that are moving upwards cannot count as standing on a platform.
There are two possible values of <platform_check_type> - PLATFORM_CHECK_TYPE.quick and PLATFORM_CHECK_TYPE.precise.
"Quick" only checks if the player is a single pixel above a platform to determine if they are standing on it or not. Overlapping platforms may not work correctly.
"Precise" checks every platform near the player, which allows players to collide with overlapping platforms.
*/
function on_plat() {
	var _x, _y, _vsp, _f;
	_x = argument_count > 0 ? argument[0] : x;
	_y = argument_count > 1 ? argument[1] : y;
	_vsp = argument_count > 2 ? argument[2] : vsp;
	_f = [FLAG.plat];

	//Direct collision checking - fast
	if (platform_check_type == PLATFORM_CHECK_TYPE.quick)
		{	
		if (collision(_x, _y + 1, _f) && 
			!collision(_x, _y, _f) && _vsp >= 0)
			{
			return true;
			}
		}
	else
	//Multi-platform list collision checking - slow
	if (platform_check_type == PLATFORM_CHECK_TYPE.precise)
		{
		var _array = collision(_x, _y + 1, _f, true);
		//Loop through all collisions
		for(var i = 0; i < array_length(_array); i++)
			{
			var _plat = _array[i];
			//If you above the platform
			if ((bbox_bottom - 1) < _plat.bbox_top && _vsp >= 0)
				{
				return true;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */