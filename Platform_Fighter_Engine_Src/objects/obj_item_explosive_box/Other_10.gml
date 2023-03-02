var _s = custom_entity_struct;
if (_s.self_hitlag_frame == 0)
	{
	//Exploding
	if (_s.exploding)
		{
		//No longer acts as a platform
		collision_flag_set(id, FLAG.plat, false);
		
		//On the first frame of exploding
		if (_s.lifetime == 5)
			{
			//Hitbox
			var _hitbox = hitbox_create_melee(0, 0, 2.5, 2.5, 20, 5, 2, 10, 0, 5, SHAPE.circle, 0, FLIPPER.from_hitbox_center);
			_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.lines];
			_hitbox.hit_sfx = -1;
			_hitbox.knockback_state = PLAYER_STATE.balloon;
			_hitbox.techable = false;
			_hitbox.hitstun_scaling = 0.5;
			
			//Effects
			var _vfx = vfx_create(spr_dspec_c4_explosion, 1, 0, 34, x, y, 2, 0);
			_vfx.important = true;
			game_sound_play(snd_hit_explosion4);
			camera_shake(5);
			}
		}
	//Normal
	else
		{
		//Gravity
		vsp = min(vsp + 0.7, 6);

		//Movement
		var _results = entity_move_simple(hsp, vsp, false, false, 0, false);
		hsp = _results.hsp;
		vsp = _results.vsp;
	
		//Create a platform when you're on the ground
		if (on_ground())
			{
			collision_flag_set(id, FLAG.plat, true);
			}
		else
			{
			collision_flag_set(id, FLAG.plat, false);
			}
		}
		
	//Inherit the parent event
	event_inherited();
	if (!instance_exists(id)) then exit;
	}
else
	{
	_s.self_hitlag_frame -= 1;
	}
/* Copyright 2023 Springroll Games / Yosi */