///@description Called by obj_game

//Shoot a laser when the timer is out
custom_entity_struct.timer -= 1;
if (custom_entity_struct.timer <= 0)
	{
	//Charging animation
	if (custom_entity_struct.phase == 0)
		{
		custom_entity_struct.phase = 1;
		custom_entity_struct.timer = 20;
		image_index = 1;
		}
	//Shoot the laser
	else if (custom_entity_struct.phase == 1)
		{
		custom_entity_struct.phase = 2;
		custom_entity_struct.count -= 1;
		if (custom_entity_struct.mode == 0)
			{
			custom_entity_struct.timer = 25;
			var _hitbox = hitbox_create_melee(640, 0, 20, 0.3, 3, 6, 0.5, 1, 60, 13, SHAPE.square, 0);
			_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
			_hitbox.hit_sfx = snd_hit_electro;
			_hitbox.extra_hitlag = 19;
			}
		else if (custom_entity_struct.mode == 1)
			{
			custom_entity_struct.timer = 35;
			var _hitbox = hitbox_create_melee(640, 0, 20, 0.3, 3, 6, 0.5, 1, 60, 26, SHAPE.square, 0);
			_hitbox.hit_vfx_style = HIT_VFX.electric;
			_hitbox.hit_sfx = snd_hit_electro;
			_hitbox.extra_hitlag = 29;
			}
		else if (custom_entity_struct.mode == 2)
			{
			custom_entity_struct.timer = 20;
			var _hitbox = hitbox_create_melee(640, 0, 20, 0.3, 2, 6, 0.3, 1, 60, 5, SHAPE.square, 0);
			_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
			_hitbox.hit_sfx = snd_hit_electro;
			_hitbox.extra_hitlag = 19;
			
			hitbox_group_reset(0);
			}
		hitbox_group_whitelist_id(owner, 0);
		}
	else
		{
		//Multiple shots
		if (custom_entity_struct.count > 0)
			{
			custom_entity_struct.phase = 0;
			custom_entity_struct.timer = 20;
			}
		else
			{
			instance_destroy();
			with(owner)
				{
				vfx_create_color(spr_fair_samus_burst, 1, 0, 20, other.x, other.y, 1, 0, "VFX_Layer_Below");
				}
			}
		}
	}

//Moving
entity_move_simple(hsp, vsp, false, false, 0, true);

//No hitlag
self_hitlag_frame = 0;

//Destroy if the owner is dead
with(owner)
	{
	if (is_knocked_out())
		{
		instance_destroy(other);
		vfx_create_color(spr_fair_samus_burst, 1, 0, 20, other.x, other.y, 1, 0, "VFX_Layer_Below");
		exit;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */