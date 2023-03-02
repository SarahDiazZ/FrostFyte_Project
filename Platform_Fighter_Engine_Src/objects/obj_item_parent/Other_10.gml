///@description (Inherit at the end of the event)
var _s = custom_entity_struct;
var _ids = custom_ids_struct;

//Held items
if (_ids.item_holder != noone)
	{
	//Drop if the holder no longer exists, or if the holder swapped items
	if (!instance_exists(_ids.item_holder))
		{
		_ids.item_holder = noone;
		_s.item_thrown = true;
		}
	else if (_ids.item_holder.item_held != id)
		{
		_ids.item_holder = noone;
		_s.item_thrown = true;
		}
	}

//Lifetime
_s.lifetime -= 1;
if (_s.lifetime <= 0)
	{
	instance_destroy();
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */