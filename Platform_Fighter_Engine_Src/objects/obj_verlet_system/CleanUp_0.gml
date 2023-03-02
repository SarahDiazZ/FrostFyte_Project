///@description Destroy all associated points / sticks
for(var i = 0; i < array_length(verlet_points); i++)
	{
	instance_destroy(verlet_points[@ i]);
	}
verlet_points = noone;
for(var i = 0; i < array_length(verlet_sticks); i++)
	{
	instance_destroy(verlet_sticks[@ i]);
	}
verlet_sticks = noone;

/* Copyright 2023 Springroll Games / Yosi */