function dash_attack_dread() {
	//Dash Attack
	/*
	- Perform a running uppercut, then shoot forwards
	- You can hold backwards during the uppercut to slide backwards when firing the shot
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dash_attack_dread;
				anim_speed = 0;
				anim_frame = 0;
			
				custom_ids_struct.dash_attack_dread_hitbox = noone;
			
				attack_frame = 7;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Speeds
				friction_gravity(slide_friction);
				
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				if (attack_frame == 1)
					anim_frame = 2;
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
					
					//Speed
					speed_set(sign(facing) * 6, 0, false, false);
					
					//VFX
					vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
					
					//Hitboxes
					var _hitbox = hitbox_create_melee(42, -12, 0.8, 1.2, 4, 8, 0.2, 12, 25, 2, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.techable = false;
					_hitbox.di_angle = 0;
					_hitbox.custom_hitstun = 25;
			
					attack_phase++;
					attack_frame = 15;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 14)
					{
					anim_frame = 4;
					
					//Hitboxes
					var _hitbox = hitbox_create_melee(38, -48, 0.8, 0.8, 4, 8, 0.2, 12, 25, 2, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.techable = false;
					_hitbox.di_angle = 0;
					_hitbox.custom_hitstun = 25;
					}
				if (attack_frame == 13)
					{
					anim_frame = 5;
					
					//Hitboxes
					var _hitbox = hitbox_create_melee(20, -62, 1.1, 0.6, 4, 8, 0.2, 12, 25, 2, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.techable = false;
					_hitbox.di_angle = 0;
					_hitbox.custom_hitstun = 25;
					}
					
				//Speed change
				if (attack_frame == 12)
					{
					//Stop at shields
					var _hit_shield = attack_connected(true, true);
					if (_hit_shield)
						{
						speed_set(hsp / 4, 0, false, false);
						}
						
					//Boost
					if (stick_tilted(Lstick, DIR.horizontal))
						{
						var _dir = sign(stick_get_value(Lstick, DIR.horizontal));
						if (_dir == facing)
							{
							//You can't move forwards more if you already hit a shield
							if (!_hit_shield)
								{
								speed_set(_dir * 7, 0, false, false);
								}
							}
						else
							{
							speed_set(_dir * 7, 0, false, false);
							}
						}
					}
				
				//Animation
				if (attack_frame == 12)
					anim_frame = 6;
				if (attack_frame == 11)
					anim_frame = 7;
				if (attack_frame == 9)
					anim_frame = 8;
				if (attack_frame == 7)
					anim_frame = 9;
				if (attack_frame == 5)
					anim_frame = 10;
				if (attack_frame == 3)
					anim_frame = 11;
			
				if (attack_frame == 0)
					{
					anim_frame = 12;
					
					//VFX
					var _vfx = vfx_create(spr_dash_attack_dread_explosion, 1, 0, 18, x + (facing * 122), y + 10, 2, 0);
					_vfx.vfx_xscale = facing * 2;
					_vfx.vfx_yscale = choose(-2, 2);
					
					//Explosion
					var _hitbox = hitbox_create_melee(122 - abs(hsp), 10, 0.9, 0.9, 8, 6, 0.9, 12, 45, 3, SHAPE.circle, 1);
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.shieldstun_scaling = 2;
					custom_ids_struct.dash_attack_dread_hitbox = _hitbox;
					var _hitbox = hitbox_create_melee(42, 10, 1.3, 0.4, 8, 6, 0.9, 8, 45, 3, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					
					attack_phase++;
					attack_frame = 35;
					}
				break;
				}
			//Active -> Endlag
			case 2:
				{
				//Speeds
				friction_gravity(slide_friction);
				
				//Move the hitbox
				var _h = custom_ids_struct.dash_attack_dread_hitbox;
				if (instance_exists(_h))
					{
					hitbox_move_attached(_h, _h.xstart, _h.ystart, true);
					}

				//Animation
				if (attack_frame == 34)
					anim_frame = 13;
				if (attack_frame == 32)
					anim_frame = 14;
				if (attack_frame == 22)
					anim_frame = 15;
				if (attack_frame == 7)
					anim_frame = 16;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */