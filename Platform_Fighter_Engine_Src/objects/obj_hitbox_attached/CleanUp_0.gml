///@description
//Inherit the parent event
event_inherited();

if (instance_exists(owner) && is_array(owner.my_hitboxes))
	{
	array_delete(owner.my_hitboxes, array_find(owner.my_hitboxes, id), 1);
	}
/* Copyright 2023 Springroll Games / Yosi */