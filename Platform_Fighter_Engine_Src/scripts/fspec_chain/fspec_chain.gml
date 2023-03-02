function fspec_chain() {
	//Forward Special
	/*
	- Creates a chain in front that can be moved around with the left stick
	- The tip of the chain stuns the opponent
	- The chain only resets hitboxes when it moves
	- Hold the button to use the chain for longer
	- You can tether to ledges with it
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);

	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		aerial_drift();
		}

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec_chain;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 17;
				
				callback_add(callback_draw_end, fspec_chain_draw);
				
				custom_attack_struct.segments = [];
				custom_attack_struct.repeats = 0;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 10; //Min chain hold time
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 6)
					{
					//Create chain
					for(var i = 0; i < 12; i++)
						{
						var _len = array_length(custom_attack_struct.segments);
						var _seg = [];
						_seg[0] = x + facing * (12 * _len);
						_seg[1] = y;
						_seg[2] = 0;
						_seg[3] = 0;
						if (_len == 11)
							{
							var _hitbox = hitbox_create_melee(_seg[0], _seg[1], 0.2, 0.2, 2, 1, 0.4, 4, 120, -1, SHAPE.square, 0);
							_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
							_hitbox.hit_sfx = snd_hit_weak;
							_hitbox.extra_hitlag = 4;
							_hitbox.asdi_multiplier = 2;
							_hitbox.drift_di_multiplier = 2;
							_hitbox.check_first = true;
							}
						else
							{
							var _hitbox = hitbox_create_melee(_seg[0], _seg[1], 0.1, 0.1, 1, 1, 0.4, 3, 45, -1, SHAPE.square, 0);
							_hitbox.hit_sfx = snd_hit_weak2;
							_hitbox.asdi_multiplier = 2;
							_hitbox.drift_di_multiplier = 2;
							}
						custom_attack_struct.segments[@ _len] = _seg;
						var _property = "chain" + string(i);
						variable_struct_set(custom_ids_struct, _property, _hitbox);
						}
					anim_frame = 3;
					}
				
				//Ledge tether
				if (attack_frame == 3)
					{
					anim_frame = 4;
					if (check_ledge_tether(128, x + (facing * 64), y))
						{
						attack_stop_preserve_state();
						return;
						}
					}
				
				//Chain logic
				custom_attack_struct.repeats = max(--custom_attack_struct.repeats, 0)
				var _num = array_length(custom_attack_struct.segments);
				if (_num > 0)
					{
					if (stick_tilted(Lstick))
						{
						var _seg = custom_attack_struct.segments[@ 0];
						var _dir = stick_get_direction(Lstick);
						var _len = stick_get_distance(Lstick);
						_seg[@ 0] = x + (lengthdir_x(_len, _dir) * 14);
						_seg[@ 1] = y + (lengthdir_y(_len, _dir) * 14);
						_seg[@ 2] = 0;
						_seg[@ 3] = 0;
						if (stick_flicked(Lstick))
							{
							//Reset hitboxes
							if (custom_attack_struct.repeats == 0)
								{
								hitbox_group_reset_all();
								custom_attack_struct.repeats = 10;
								}
							for(var m = 1; m < _num; m++)
								{
								var _seg = custom_attack_struct.segments[@ m];
								_seg[@ 2] = (lengthdir_x(_len, _dir) * (5 + m));
								_seg[@ 3] = (lengthdir_y(_len, _dir) * (5 + m));
								}
							}
						}
					else
						{
						var _seg = custom_attack_struct.segments[@ 0];
						_seg[@ 0] = x;
						_seg[@ 1] = y;
						_seg[@ 2] = approach(_seg[2], 0, 0.1);
						_seg[@ 3] = min(_seg[3] + 0.35, 6);
						}
					}
				for(var i = 1; i < _num; i++)
					{
					var _seg = custom_attack_struct.segments[@ i];
					var _pre = custom_attack_struct.segments[@ i - 1];
					//Movement & Collisions
					_seg[@ 2] = approach(_seg[2], 0, 0.1);
					_seg[@ 3] = min(_seg[3] + 0.35, 6);
					var _mask = mask_index;
					mask_index = spr_pixel;
					if (!collision(_seg[0] + _seg[2], _seg[1], [FLAG.solid]))
						{
						_seg[@ 0] += _seg[2];
						}
					else
						{
						for(var j = 0; j < abs(_seg[2]); j++)
							{
							if (!collision(_seg[0] + sign(_seg[2]), _seg[1], [FLAG.solid]))
								_seg[@ 0] += sign(_seg[2]);
							else
								{
								_seg[@ 2] = 0;
								break;
								}
							}
						}
					for(var j = 0; j < abs(_seg[3]); j++)
						{
						if (!collision(_seg[0], _seg[1] + sign(_seg[3]), [FLAG.solid]) &&
							!(sign(_seg[3]) > 0 && on_ground(_seg[0], _seg[1] + sign(_seg[3]))))
							_seg[@ 1] += sign(_seg[3]);
						else
							{
							_seg[@ 3] = 0;
							break;
							}
						}
					mask_index = _mask;
					//Pulling force
					var _dist = point_distance(_seg[0], _seg[1], _pre[0], _pre[1]);
					var _dir = point_direction(_pre[0], _pre[1], _seg[0], _seg[1]);
					if (_dist > 14)
						{
						_seg[@ 0] = _pre[0] + lengthdir_x(14, _dir);
						_seg[@ 1] = _pre[1] + lengthdir_y(14, _dir);
						_seg[@ 2] = clamp(_seg[2], -5, 5);
						_seg[@ 3] = clamp(_seg[3], -5, 5);
						}
					//Update hitboxes
					var _property = "chain" + string(i);
					hitbox_move_attached(variable_struct_get(custom_ids_struct, _property), _seg[0], _seg[1], true);
					}
				
				if (attack_frame == 0)
					{
					if (!input_held(INPUT.special))
						{
						attack_phase++;
						attack_frame = 20;
						hitbox_destroy_attached_all();
						}
					else
						{
						//Animation
						if (stick_tilted(Lstick))
							{
							var _dir = stick_get_direction(Lstick);
							if (facing == -1) then _dir = (-_dir + 540) % 360;
							var _num = ((_dir + 22.5) div 45);
							switch(_num)
								{
								case 0: anim_frame = 7; break;
								case 1: anim_frame = 6; break;
								case 2: anim_frame = 5; break;
								case 3: anim_frame = 12; break;
								case 4: anim_frame = 11; break;
								case 5: anim_frame = 10; break;
								case 6: anim_frame = 9; break;
								case 7: anim_frame = 8; break;
								}
							}
						else
							{
							anim_frame = 4;
							}
						}
					}
				break;
				}
			//Endlag
			case 2:
				{
				if (attack_frame == 13)
					anim_frame = 3;
				if (attack_frame == 6)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				}
			}
		}
	//Movement
	move();


}

/* Copyright 2023 Springroll Games / Yosi */