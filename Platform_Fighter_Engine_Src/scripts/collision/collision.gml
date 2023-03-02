///@category Collisions
///@param {real} x					The x position to check for a collision at
///@param {real} y					The y position to check for a collision at
///@param {array} [flags]			The collision flags to check for, from the FLAG enum
///@param {bool} [array]			Whether to return an array of ids the object is colliding with, or a single id of the first object detected
///@param {asset} [obj]				The object to check collisions with. This object must have a "collision_flags" variable if any flags are given
///@param {bool} [any_flags]		Whether to count instances that have any of the flags, instead of only instances with all of the flags
/*
Checks for a collision at a certain x and y.
This function essentially moves the calling object to the given x and y, checks for collisions, and then moves it back. As such, the entire collision mask of the calling object is taken into account; this function does not only check a single coordinate.
If a flags array is given, this function will only count collisions with instances that have all of the flags (unless the "any_flags" argument is true).
If the array argument is set to true, this function will return an array of the ids of the objects in collision. Otherwise, it will return a single id of the first object found to be in collision.
*/
function collision() {
	var _x = argument[0];
	var _y = argument[1];
	var _flags = argument_count > 2 ? argument[2] : [];
	var _a = argument_count > 3 ? argument[3] : false;
	var _o = argument_count > 4 ? argument[4] : obj_collidable;
	var _any = argument_count > 5 ? argument[5] : false;
	var _list = temp_list_get();

	//Merge the flags into a number to easily check
	var _f = 0;
	for(var i = 0; i < array_length(_flags); i++)
		{
		_f = _f | (1 << _flags[@ i]);
		}

	//Clear the list
	ds_list_clear(_list);

	//Populate the list with instance ids
	var _size = instance_place_list(_x, _y, _o, _list, true);
	if (_size > 0)
		{
		if (_a)
			{
			if (_f == 0)
				{
				var _array = array_create(_size, noone);
				//Make an array of the list
				for(var i = 0; i < _size; i++)
					{
					_array[i] = _list[| i];
					}
				return _array;
				}
			else
				{
				var _array = [];
				//Make an array of the items in the list that have the correct flags
				for(var i = 0; i < _size; i++)
					{
					var _inst = _list[| i];
					var _correct_flags = _any
						? (_f & _inst.collision_flags > 0)
						: (_f & _inst.collision_flags == _f);
					if (_correct_flags)
						{
						_array[array_length(_array)] = _inst;
						}
					}
				return _array;
				}
			}
		else
			{
			if (_f == 0)
				{
				//Return one of the instances from the list
				var _inst = _list[| 0];
				return _inst;
				}
			else
				{
				//Return the first instance to have the correct flags
				for(var i = 0; i < _size; i++)
					{
					var _inst = _list[| i];
					var _correct_flags = _any
						? (_f & _inst.collision_flags > 0)
						: (_f & _inst.collision_flags == _f);
					if (_correct_flags)
						{
						return _inst;
						}
					}
				return noone;
				}
			}
		}
	else
		{
		//Return either a blank array or noone
		return _a ? [] : noone;
		}
}
/* Copyright 2023 Springroll Games / Yosi */