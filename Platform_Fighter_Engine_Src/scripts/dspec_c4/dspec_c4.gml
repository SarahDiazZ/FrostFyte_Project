function dspec_c4() {
	//Down Special
	/*
	- Attaches to players or blocks
	- If there is already a C4 active, using the move explodes it
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;

	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction);
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
				anim_sprite = spr_dspec_c4;
				anim_frame = 0;
				anim_speed = 0;
			
				//Check if the C4 exists already or not
				var _exists = false;
				with(obj_dspec_c4_bomb)
					{
					if (owner == other.id)
						{
						_exists = true;
						break;
						}
					}
				if (_exists)
					{
					attack_phase = 2;
					attack_frame = 30;
					anim_frame = 5;
					game_sound_play(snd_c4);
					}
				else
					{
					attack_frame = 10;
					}
					
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//EX
				ex_move_allow(2);
				
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 15;
					
					//EX
					if (ex_move_is_activated())
						{
						var _entity = entity_create(x, y, obj_dspec_c4_bomb, "Player_Front");
						_entity.hsp = -6;
						_entity.vsp = -3;
						_entity.custom_entity_struct.auto_explode_timer = 720;
						var _entity = entity_create(x, y, obj_dspec_c4_bomb, "Player_Front");
						_entity.hsp = 0;
						_entity.vsp = -2;
						_entity.custom_entity_struct.auto_explode_timer = 720;
						var _entity = entity_create(x, y, obj_dspec_c4_bomb, "Player_Front");
						_entity.hsp = 6;
						_entity.vsp = -3;
						_entity.custom_entity_struct.auto_explode_timer = 720;
						}
					//Grounded
					else if (on_ground())
						{
						entity_create(x, (bbox_bottom - 1) - 1, obj_dspec_c4_bomb, "Player_Front");
						}
					//Aerial
					else
						{
						entity_create(x, y, obj_dspec_c4_bomb, "Player_Front");
						}
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;

				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Detonate
			case 2:
				{
				if (attack_frame == 30)
					anim_frame = 6;
				if (attack_frame == 26)
					anim_frame = 7;
				if (attack_frame == 20)
					anim_frame = 8;
				
				if (attack_frame == 15)
					{
					//Explode all the C4s you own
					with(obj_dspec_c4_bomb)
						{
						var _s = custom_entity_struct;
						var _ids = custom_ids_struct;
						
						//If the C4 started to auto explode already, you can't explode it
						if (owner == other.id && _s.auto_explode_timer > (120 - 15))
							{
							_s.explosion_time = 10;
						
							if (_ids.attached != noone)
								{
								//Sweetspot
								var _hitbox = hitbox_create_melee(0, 0, 1, 1, 11, 7, 0.6, 11, 90, 1, SHAPE.circle, 0);
								_hitbox.hit_sfx = snd_hit_explosion4;
								_hitbox.hit_vfx_style = HIT_VFX.explosion;
						
								//Weak hitbox
								var _hitbox = hitbox_create_melee(0, 0, 2.5, 2.5, 5, 6, 0.5, 7, 90, 5, SHAPE.circle, 0);
								_hitbox.hit_sfx = snd_hit_explosion4;
								_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
								}
							else
								{
								//Sweetspot
								var _hitbox = hitbox_create_melee(0, 0, 1, 1, 11, 10, 1, 11, 90, 1, SHAPE.circle, 0);
								_hitbox.hit_sfx = snd_hit_explosion4;
								_hitbox.hit_vfx_style = HIT_VFX.explosion;
						
								//Weak hitbox
								var _hitbox = hitbox_create_melee(0, 0, 2.5, 2.5, 5, 8, 0.9, 7, 90, 5, SHAPE.circle, 0);
								_hitbox.hit_sfx = snd_hit_explosion4;
								_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
								}
						
							//Explosion VFX
							var _vfx = vfx_create(spr_dspec_c4_explosion, 1, 0, 34, x, y, 2, 0);
							_vfx.important = true;
							game_sound_play(snd_hit_explosion2);
							camera_shake(5);
							}
						}
					attack_cooldown_set(120);
					}
				
				if (attack_frame == 14)
					anim_frame = 9;
				if (attack_frame == 7)
					anim_frame = 10;
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */