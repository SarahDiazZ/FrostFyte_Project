///@description
if (surface_exists(obj_lava_filter.surf))
	{
	surface_set_target(obj_lava_filter.surf);
	
	draw_self();
	
	surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */