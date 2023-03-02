///@category Debugging
/*
Returns a struct containing the current number of all dynamic resources.
By default, the dynamic resources counted are:
	- DS Grids
	- DS Lists
	- DS Maps
	- DS Priority Queues
	- DS Queues
	- DS Stacks
	- Buffers
	- Surfaces
	- Instances
*/
function dynamic_resource_count_all() {
	return 
		{
		grid : dynamic_resource_count(DR.grid),
		list : dynamic_resource_count(DR.list),
		map : dynamic_resource_count(DR.map),
		priority : dynamic_resource_count(DR.priority),
		queue : dynamic_resource_count(DR.queue),
		stack : dynamic_resource_count(DR.stack),
		buffer : dynamic_resource_count(DR.buffer),
		surface : dynamic_resource_count(DR.surface),
		instance : instance_count,
		};
}
/* Copyright 2023 Springroll Games / Yosi */