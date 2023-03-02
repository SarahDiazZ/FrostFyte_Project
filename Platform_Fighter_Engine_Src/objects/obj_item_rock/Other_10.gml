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
		vsp = min(vsp + 0.5, 12);
		var _results = entity_move_simple(hsp, vsp, false, true, 0.9, false);
		hsp = _results.hsp;
		vsp = max(vsp, _results.vsp);
	
		//Change the hitbox angle based on the current movement
		if (_ids.hitbox != noone && instance_exists(_ids.hitbox))
			{
			if (hsp == 0)
				{
				if (vsp > 1) then _ids.hitbox.angle = 270;
				if (vsp < -1) then _ids.hitbox.angle = 90;
				}
			}
	
		if (on_ground())
			{
			hsp = 0;
			vsp = 0;
		
			//Destroy the hitbox
			with(_ids.hitbox) instance_destroy();
		
			//Turn into a solid block when on the ground
			if (!collision_flag_exists(id, FLAG.solid))
				{
				collision_flag_set(id, FLAG.solid, true);
			
				//Move left or right to avoid players
				if (place_meeting(x, y, obj_player))
					{
					for(var i = 0; i < 100; i++)
						{
						if (!place_meeting(x + i, y, obj_player))
							{
							x += i;
							break;
							}
						if (!place_meeting(x - i, y, obj_player))
							{
							x -= i;
							break;
							}
						}
					}
				
				//Move up out of blocks
				move_out_of_blocks(90);
			
				//Move all players out of blocks
				with(obj_player)
					{
					move_out_of_blocks(361);
					}
				
				//Visual effects
				vfx_create(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, 1, 90, "VFX_Layer_Below");
				}
			}

		//Inherit the parent event
		event_inherited();
		if (!instance_exists(id)) then exit;
		}
	}
	
self_hitlag_frame = max(0, self_hitlag_frame - 1);

//The rock is not solid when held
if (_ids.item_holder != noone)
	{
	collision_flag_set(id, FLAG.solid, false);
	}
	
//Move
item_move_with_holder();

//Destroy when outside the room
if (blastzones_check())
	{
	instance_destroy();
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */