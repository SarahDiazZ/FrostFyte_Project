var _s = custom_entity_struct;

_s.flip_timer = max(0, _s.flip_timer - 1);

//Movement
hsp = lerp(hsp, 0, 0.1);
vsp = lerp(vsp, 0, 0.1);
var _results = entity_move_simple(hsp, vsp, false, true, 0.8, false);
hsp = _results.hsp;
vsp = _results.vsp;
if (abs(hsp) < 0.1) then hsp = 0;
if (abs(vsp) < 0.1) then vsp = 0;

//Field
if (_s.lifetime % 12 == 0)
	{
	//Find all nearby players
	with(obj_player)
		{
		if (point_distance(x, y, other.x, other.y) < 100)
			{
			//Damaging zone
			if (_s.flip)
				{
				apply_damage(id, 2);
				var _vfx = vfx_create(spr_item_flip_field_sign, 0, 1, 45, x + prng_number(0, 9, -9), y + prng_number(1, 9, -9), 2, 0);
				_vfx.fade = true;
				}
			//Healing zone
			else
				{
				if (!is_launched())
					{
					apply_damage(id, -2);
					var _vfx = vfx_create(spr_item_flip_field_sign, 0, 0, 45, x + prng_number(0, 9, -9), y + prng_number(1, 9, -9), 2, 0);
					_vfx.fade = true;
					}
				}
			}
		}
	}

if (_s.flip_timer > 0)
	{
	image_index = _s.flip ? 3 : 1;
	}
else
	{
	image_index = _s.flip ? 2 : 0;
	}
	
//Inherit the parent event
event_inherited();
if (!instance_exists(id)) then exit;
/* Copyright 2023 Springroll Games / Yosi */