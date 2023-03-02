var _s = custom_entity_struct;
var _ids = custom_ids_struct;

//Hitlag
if (self_hitlag_frame <= 0)
	{
	//If the item is not being held
	if (_ids.item_holder == noone)
		{
		//Movement
		hsp = approach(hsp, 0, 0.1);
		vsp = min(vsp + 0.4, 9);
		var _results = entity_move_simple(hsp, vsp, false, true, 0.9, false);
		hsp = _results.hsp;
		vsp = max(vsp, _results.vsp);
	
		if (on_ground())
			{
			//Visual effects
			if (vsp > 1)
				{
				vfx_create(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, 0.25, 90, "VFX_Layer_Below");
				}
			
			hsp = 0;
			vsp = 0;
			_s.angle = 0;
		
			//Destroy the hitbox
			with(_ids.hitbox) instance_destroy();
			}
		else
			{
			if (hsp != 0)
				{
				_s.angle += sign(hsp) * 18;
				}
			else
				{
				_s.angle += sign(abs(vsp)) * 6;
				}
			}
			
		//Hitbox angle
		hitbox_sprite_angle_set(_ids.hitbox, _s.angle, true);

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