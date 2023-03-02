function uspec_bowser() {
	//Neutral Special
	/*
	- Multihit spin attack
	- Always hits in a direction based on the way you were facing when the attack started
	- Press down or the attack input before the first hitbox comes out to fall downwards with the attack
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_uspec_bowser;
				anim_frame = 0;
				anim_speed = 0;
			
				landing_lag = 25;
			
				if (on_ground())
					{
					speed_set(stick_get_value(Lstick, DIR.horizontal) * 4, 0, false, false);
					attack_frame = 12;
					}
				else
					{
					if (vsp > 0)
						{
						speed_set(0, -1, true, false);
						}
					attack_frame = 8;
					}
					
				//EX
				ex_move_reset();
				return;
				}
			//Startup
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Animation
				if (attack_frame == 7)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_frame = 30;
					
					//EX
					if (ex_move_is_activated())
						{
						attack_phase = 7;
						attack_frame = 24;
						landing_lag = 35;
						speed_set(stick_get_value(Lstick, DIR.horizontal) * 6, -20, true, false);
						
						//Explosion hitbox
						var _hitbox = hitbox_create_melee(0, 0, 2.75, 2.75, 4, 5, 0.7, 6, 45, 1, SHAPE.circle, 0, FLIPPER.from_hitbox_center_horizontal);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_medium, HIT_VFX.lines];
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.hitstun_scaling = 0.5;
						
						//Body hitbox
						var _hitbox = hitbox_create_melee(0, 0, 1, 1, 10, 8, 1.2, 10, 90, 14, SHAPE.circle, 1);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
						_hitbox.hit_sfx = snd_hit_strong3;
						
						//VFX
						vfx_create(spr_hit_explosion, 1, 1, 16, x + hsp, y + vsp, 1, 0);
						camera_shake(0, 5);
						}
					//Aerial
					else if (!on_ground())
						{
						//Horizontal Boost
						speed_set(stick_get_value(Lstick, DIR.horizontal) * 4, -12, true, false);
						
						if (stick_get_value(Lstick, DIR.down) > stick_tilt_amount || input_pressed(INPUT.shield, 8))
							{
							//Aerial Drop version
							speed_set(0, 16, true, false);
							var _hitbox = hitbox_create_melee(0, 5, 0.8, 0.6, 9, 8, 1.1, 9, 290, 30, SHAPE.circle, 0);
							_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.slash_medium];
							_hitbox.hit_sfx = snd_hit_strong2;
							attack_phase = 5;
							}
						else
							{
							//Aerial version
							var _hitbox = hitbox_create_magnetbox(0, 5, 0.8, 0.5, 1, 2, hsp * 4 * facing, (vsp * 4) - 2, 10, 3, SHAPE.circle, 1);
							_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
							_hitbox.shieldstun_scaling = 0;
							attack_phase = 1;
							}
							
						//Aerial tilt
						anim_angle = point_direction(0, 0, hsp * 0.25, vsp) - 90;
						}
					//Grounded
					else
						{
						var _hitbox = hitbox_create_magnetbox(0, 5, 0.8, 0.5, 1, 2, hsp * 4 * facing, (vsp * 4) - 2, 10, 3, SHAPE.circle, 1);
						_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
						_hitbox.shieldstun_scaling = 0;
						attack_phase = 3;
						}
					}
				break;
				}
			//Active (Aerial)
			case 1:
				{
				//Landing
				if (cancel_ground_check()) return;
				
				//Ledges
				if (check_ledge_grab()) return;
				
				aerial_drift();
				friction_gravity(air_friction, 0.35, 12);
					
				//Aerial tilt
				anim_angle = point_direction(0, 0, hsp * 0.25, vsp) - 90;
				
				//Animation
				if (attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 7)
						anim_frame = 4;
					}
				
				//Multihit
				if (attack_frame % 3 == 0 && attack_frame != 0)
					{	
					hitbox_group_reset(1);
				
					var _hitbox = hitbox_create_magnetbox(0, 5, 0.8, 0.5, 1, 2, hsp * 4 * facing, (vsp * 4) - 2, 10, 3, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.shieldstun_scaling = 0;
					}
					
				//VFX
				if (attack_frame % 6 == 0)
					{
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, 90 + anim_angle, "VFX_Layer_Below");
					_vfx.vfx_blend = c_ltgray;
					_vfx.vfx_xscale = prng_choose(0, -2, 2);
					_vfx.vfx_yscale = prng_choose(1, -2, 2);
					_vfx.shrink = 0.9;
					}
			
				if (run && attack_frame == 0)
					{
					anim_frame = 8;
					
					//Final hit
					var _hitbox = hitbox_create_melee(0, 5, 0.8, 0.6, 4, 10, 0.4, 8, 50, 3, SHAPE.circle, 2);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hitstun_scaling = 0.5;

					attack_phase++;
					attack_frame = 25;
					}
				break;
				}
			//Finish (Aerial)
			case 2:
				{
				//Landing
				if (cancel_ground_check()) return;
				
				//Ledges
				if (check_ledge_grab()) return;
				
				//Wall Jump
				if (check_wall_jump()) return;
					
				friction_gravity(air_friction, grav, max_fall_speed);
				
				//Animation
				if (attack_frame == 18)
					anim_frame = 9;
				if (attack_frame == 12)
					anim_frame = 10;
				if (attack_frame == 6)
					anim_frame = 11;
			
				if (attack_frame == 0)
					{
					anim_angle = 0;
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//Active (Grounded)
			case 3:
				{
				//Horizontal movement
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					speed_set(sign(stick_get_value(Lstick, DIR.horizontal)) * 0.5, 0, true, false);
					hsp = clamp(hsp, -4, 4);
					}

				//Animation
				if (attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 7)
						anim_frame = 4;
					}
				
				//Multihits
				if (attack_frame % 3 == 0 && attack_frame != 0)
					{	
					hitbox_group_reset(1);
				
					var _hitbox = hitbox_create_magnetbox(0, 5, 0.8, 0.6, 1, 2, hsp * 4 * facing, (vsp * 4) - 2, 10, 3, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.shieldstun_scaling = 0;
					}
					
				//VFX
				if (attack_frame % 6 == 0)
					{
					//VFX
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 20, x, (bbox_bottom - 1) - 4, 2, 90, "VFX_Layer_Below");
					_vfx.vfx_blend = c_ltgray;
					_vfx.vfx_xscale = prng_choose(0, -2, 2);
					_vfx.vfx_yscale = prng_choose(1, -2, 2);
					_vfx.shrink = 0.9;
					}
			
				if (run && attack_frame == 0)
					{
					anim_frame = 8;
					
					//Final hit
					var _hitbox = hitbox_create_melee(0, 5, 0.8, 0.6, 6, 8, 0.5, 12, 55, 3, SHAPE.circle, 2);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.shieldstun_scaling = 0.1;
					attack_phase++;
					attack_frame = 25;
					}
				break;
				}
			//Finish (Grounded)
			case 4:
				{
				friction_gravity(ground_friction);
				
				//Animation
				if (attack_frame == 18)
					anim_frame = 9;
				if (attack_frame == 12)
					anim_frame = 10;
				if (attack_frame == 6)
					anim_frame = 11;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			//Active (Aerial Drop)
			case 5:
				{
				//Landing
				if (cancel_ground_check()) return;
				
				aerial_drift();
				friction_gravity(air_friction, 0.35, 12);
					
				//Aerial tilt
				anim_angle = point_direction(0, 0, hsp * 0.25, vsp) - 90;
				
				//Animation
				if (attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 7)
						anim_frame = 4;
					}
				
				//VFX
				if (attack_frame % 6 == 0)
					{
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, 90 + anim_angle, "VFX_Layer_Below");
					_vfx.vfx_blend = c_ltgray;
					_vfx.vfx_xscale = prng_choose(0, -2, 2);
					_vfx.vfx_yscale = prng_choose(1, -2, 2);
					_vfx.shrink = 0.9;
					}
			
				if (run && attack_frame == 0)
					{
					anim_frame = 8;
					attack_phase++;
					attack_frame = 25;
					}
				break;
				}
			//Finish (Aerial Drop)
			case 6:
				{
				if (check_ledge_grab()) return;
				
				friction_gravity(air_friction, grav, max_fall_speed);
				
				//Animation
				if (attack_frame == 18)
					anim_frame = 9;
				if (attack_frame == 12)
					anim_frame = 10;
				if (attack_frame == 6)
					anim_frame = 11;
				
				if (attack_frame == 0)
					{
					anim_angle = 0;
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//EX
			case 7:
				{
				//Ledge grab
				if (check_ledge_grab()) return;
				
				//Speeds
				if (vsp < 0)
					{
					vsp += 0.75;
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					var _dir = sign(stick_get_value(Lstick, DIR.horizontal));
					hsp = clamp(hsp + (1 * _dir), -8, 8);
					}
					
				//Aerial tilt
				anim_angle = point_direction(0, 0, hsp * 0.25, vsp) - 90;
				
				//VFX
				if (attack_frame % 5 == 0)
					{
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, 90 + anim_angle, "VFX_Layer_Below");
					_vfx.vfx_blend = c_ltgray;
					_vfx.vfx_xscale = prng_choose(0, -2, 2);
					_vfx.vfx_yscale = prng_choose(1, -2, 2);
					_vfx.shrink = 0.9;
					}
					
				//Animation
				if (attack_frame == 22) 
					anim_frame = 4;
				if (attack_frame == 20)
					anim_frame = 5;
				if (attack_frame == 18)
					anim_frame = 6;
				if (attack_frame == 16)
					anim_frame = 7;
				if (attack_frame == 13) 
					anim_frame = 8;
				if (attack_frame == 10)
					anim_frame = 9;
				if (attack_frame == 7)
					anim_frame = 10;
				if (attack_frame == 4)
					anim_frame = 11;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			}
		}
		
	//Movement
	if (on_ground())
		{
		move_grounded();
		}
	else
		{
		move();
		}
}
/* Copyright 2023 Springroll Games / Yosi */