///@category Player Standard States
/*
This script contains the default Hitstun state characters are given.

The Hitstun state is for players launched in the air due to knockback.
There is an alternate version of this state, the "balloon" state, which moves faster initially but slows down more at the end.
*/
function standard_hitstun() {
	//Contains the standard actions for the hitstun state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Hitstun"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			var _current_speed = point_distance(0, 0, hsp, vsp);
			
			//Reeling Animation
			if (is_reeling)
				{
				anim_loop_continue(my_sprites[$ "Reeling"]);
				}
			
			//Friction / Gravity
			if (!on_ground())
				{
				friction_gravity(air_friction, hitstun_grav, max_fall_speed);
				}
			else
				{
				friction_gravity(ground_friction);
				}
	
			//Drift DI
			if (state_time > drift_di_lockout)
				{
				//If stick is past threshold
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					//Drift DI cannot be used to speed up knockback to high speeds
					if (sign(stick_get_value(Lstick, DIR.horizontal)) == sign(hsp))
						{
						if (abs(hsp + drift_di_accel * sign(stick_get_value(Lstick, DIR.horizontal))) < drift_di_max * drift_di_multiplier)
							{
							hsp += drift_di_accel * sign(stick_get_value(Lstick, DIR.horizontal));
							}
						}
					else
						{
						hsp += drift_di_accel * sign(stick_get_value(Lstick, DIR.horizontal));
						}
					}
				}
	
			//End Hitstun
			if (run && state_frame == 0)
				{
				if (is_reeling)
					{
					//Go to tumble state, which can be canceled to return to normal
					state_set(PLAYER_STATE.tumble);
					run = false;
					}
				else
					{
					//Go straight to the aerial state
					state_set(PLAYER_STATE.aerial);
					run = false;
					}
				}
	
			//Slide
			if (run && on_ground() && vsp == 0 && _current_speed < bounce_minimum_speed)
				{
				var _remaining_hitstun = state_frame;
				//Knockdown
				if (is_reeling)
					{
					state_set(PLAYER_STATE.knockdown);
					if (knockdown_type == KNOCKDOWN_TYPE.slide)
						{
						state_frame = ceil(_remaining_hitstun * knockdown_slide_multiplier);
						}
					//VFX
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, 0.75, 90, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -0.75, 0.75);
					_vfx.vfx_blend = palette_color_get(palette_data, 0);
					}
				else
					{
					state_set(PLAYER_STATE.flinch);
					state_frame = ceil(_remaining_hitstun * knockdown_slide_multiplier);
					}
				//Effects
				camera_shake(1, 3);
				run = false;
				}
	
			//If you are launched hard enough, create ring effects
			if (run && state_frame % 10 == 0 && _current_speed > reeling_speed_threshold)
				{
				var _scale = clamp((_current_speed + (state_frame / 50)) / 10, 0.5, 2.5);
				var _vfx = vfx_create
					(
					spr_hit_ring,
					1,
					0,
					18,
					x,
					y,
					_scale,
					point_direction(0, 0, hsp, vsp),
					"VFX_Layer_Below"
					);
				_vfx.vfx_blend = palette_color_get(palette_data, 0);
				}
				
			//Cloud trails
			if (run && setting().knockback_trails_enable && knockback_spd > 9 && state_frame % 4 == 0)
				{
				var _hitstun_start_frame = (state_frame + state_time);
				var _scale = clamp((state_frame / _hitstun_start_frame) * (knockback_spd / 10), 1, 2.5);
				var _cloud = instance_create_layer(x, y, "VFX_Layer_Below", obj_dust_cloud);
				with(_cloud)
					{
					vfx_sprite = prng_choose(0, spr_dust_cloud, spr_dust_cloud1);
					vfx_speed = 1;
					vfx_frame = 0;
					lifetime = 17;
					vfx_xscale = _scale;
					vfx_yscale = _scale;
					vfx_angle = point_direction(0, 0, other.hsp, other.vsp) + prng_number(0, 5, -5);
					total_life = lifetime;
					var _dir = prng_number(0, 360);
					var _spd = prng_number(0, _scale * 2);
					hsp = lengthdir_x(_spd, _dir);
					vsp = lengthdir_y(_spd, _dir);
					var _color = palette_color_get(other.palette_data, 0);
					custom_vfx_struct.color =
						[
						color_get_red(_color) / 255,
						color_get_green(_color) / 255,
						color_get_blue(_color) / 255,
						];
					}
				}
	
			//If you transition to the lag state (hit into the ground), you can't fall of edges or bounce
			if (state != PLAYER_STATE.knockdown)
				{
				move_bouncing();
				}
			else
				{
				move_grounded();
				}
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */