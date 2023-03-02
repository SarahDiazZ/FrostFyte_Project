var _s = custom_entity_struct;
var _ids = custom_ids_struct;

//Hitlag
if (self_hitlag_frame <= 0)
	{
	//If the item is not being held
	if (_ids.item_holder == noone)
		{
		//Movement
		var _old_vsp = vsp;
		hsp = approach(hsp, 0, 0.05);
		vsp = min(vsp + 0.4, 12);
		var _results = entity_move_simple(hsp, vsp, false, true, 0.9, false);
		hsp = _results.hsp;
		vsp = _results.vsp;
	
		if (_old_vsp > 0 && vsp < -3)
			{
			vfx_create(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, 0.25, 90, "VFX_Layer_Below");
			}
		else
			{
			//Destroy hitbox when the ball slows down
			if ((_old_vsp > 0 && vsp < 0) && abs(hsp) < 2)
				{
				with(_ids.hitbox) instance_destroy();
				vsp = 0;
				}
			}

		//Inherit the parent event
		event_inherited();
		if (!instance_exists(id)) then exit;
		}
	}
	
self_hitlag_frame = max(0, self_hitlag_frame - 1);
	
//Move
item_move_with_holder();

//Destroy when outside the room
if (blastzones_check())
	{
	instance_destroy();
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */