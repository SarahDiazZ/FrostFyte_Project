///@category Debugging
///@param {int} type		The dynamic asset type to count, from the DR enum
/*
Returns the number of dynamic resources of the given asset type (from the DR enum) that currently exist.
For debug use ONLY.
*/
function dynamic_resource_count(_type) 
	{
	var _exists = 0;
	var _count = 0;
	for(var i = 0; i < _exists + 10; i++) 
		{
		switch(_type) 
			{
			case DR.grid:
				if (ds_exists(i, ds_type_grid)) 
					{
					_count++;
					_exists = i;
					}
				break;
			case DR.list:
				if (ds_exists(i, ds_type_list)) 
					{
					_count++;
					_exists = i;
					}
				break;
			case DR.map:
				if (ds_exists(i, ds_type_map)) 
					{
					_count++;
					_exists = i;
					}
				break;
			case DR.priority:
				if (ds_exists(i, ds_type_priority)) 
					{
					_count++;
					_exists = i;
					}
				break;
			case DR.queue:
				if (ds_exists(i, ds_type_queue))
					{
					_count++;
					_exists = i;
					}
				break;
			case DR.stack:
				if (ds_exists(i, ds_type_stack)) 
					{
					_count++;
					_exists = i;
					}
				break;
			case DR.buffer:
				if (buffer_exists(i)) 
					{
					_count++;
					_exists = i;
					}
				break;
			case DR.surface:
				if (surface_exists(i)) 
					{
					_count++;
					_exists = i;
					}
				break;
			default: crash("[dynamic_resource_count] Tried to check for a resource type that doesn't exist! (", i, ")");
			}
		}
	return _count;
}
/* Copyright 2023 Springroll Games / Yosi */