///@category Player Actions
///@func check_tech()
///@desc Allows the player to tech. Should only be used in moving scripts.
/*
Allows the player to tech (or tech roll), and returns the result of the tech, from the TECH_RESULT enum.
Warning: This function should only be used in moving scripts, and will not work properly otherwise.
*/
function check_tech() {
	var _result = TECH_RESULT.slide;
	var _spd = point_distance(0, 0, hsp, vsp);
	var _dir = point_direction(0, 0, hsp, vsp);
	var _tech_input = false;
	if (tech_buffer < tech_buffer_time && can_tech)
		{
		_tech_input = true;
		}

	//Ground Collision / Edge Collision
	if (vsp > 0 && (on_ground() || (hsp != 0 && on_ground(x + sign(hsp)) && !collision(x + sign(hsp), y, [FLAG.solid]))))
		{
		if (_tech_input)
			{
			//Reset tech buffer
			tech_buffer = tech_lockout_time;
			//Tech roll
			if (stick_tilted(Lstick, DIR.horizontal))
				{
				state_set(PLAYER_STATE.tech_rolling);
				state_phase = 0;
				state_frame = techroll_startup;
				state_facing = sign(stick_get_value(Lstick, DIR.horizontal));
				facing = state_facing;
				invulnerability_set(INV.invincible, techroll_startup);
				}
			//Tech in place
			else
				{
				state_set(PLAYER_STATE.teching);
				}
			_result = TECH_RESULT.success;
			}
		//Missed tech
		else
			{
			//Bounce
			if (_spd >= bounce_minimum_speed)
				{
				//Slopes
				var _slope = collision(x, y + 1, [FLAG.slope]);
				if (_slope != noone && sign(_slope.image_yscale) == 1)
					{
					var _newspd = (_spd * bounce_speed_multiplier);
					var _newdir = (_slope.slope_type == SLOPE_TYPE.calculated_bounce)
						? bounce_angle(_dir, _slope.slope_angle) 
						: _slope.slope_normal;
					speed_set(lengthdir_x(_newspd, _newdir), lengthdir_y(_newspd, _newdir), false, false);
					//VFX
					var _scale = clamp(_spd / 15, 0.5, 2);
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, _slope.image_xscale > 0 ? (bbox_right - 1) : bbox_left, (bbox_bottom - 1) + 1, _scale, _slope.slope_normal, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -_scale, _scale);
					_vfx.vfx_blend = palette_color_get(palette_data, 0);
					}
				else
					{
					vsp = (-vsp * bounce_speed_multiplier);
					//VFX
					var _scale = clamp(_spd / 15, 0.5, 2);
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, _scale, 90, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -_scale, _scale);
					_vfx.vfx_blend = palette_color_get(palette_data, 0);
					}
				_result = TECH_RESULT.bounce;
				}
			//Slide
			else
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
				speed_set(0, 0, true, false);
				_result = TECH_RESULT.slide;
				}
			//Effects
			camera_shake(1, 3);
			}
		}
	//Wall Collision
	else if (hsp != 0 && (collision(x + 1, y, [FLAG.solid]) || collision(x - 1, y, [FLAG.solid])))
		{
		if (_tech_input)
			{
			//Reset tech buffer
			tech_buffer = tech_lockout_time;
			//Wall Tech Jump
			if (input_pressed(INPUT.jump) || input_held(INPUT.jump) || stick_tilted(Lstick, DIR.up))
				{
				facing = (collision(x + 1, y, [FLAG.solid]) ? -1 : 1);
				state_set(PLAYER_STATE.tech_wall_jump);
				state_phase = 0;
				state_frame = wall_jump_startup;
				}
			//Wall Tech
			else
				{
				facing = (collision(x + 1, y, [FLAG.solid]) ? -1 : 1);
				state_set(PLAYER_STATE.teching);
				anim_set(my_sprites[$ "TechingW"]);
				}
			_result = TECH_RESULT.success;
			}
		//Missed tech
		else
			{
			//Bounce
			if (_spd >= bounce_minimum_speed)
				{
				//Slopes
				var _slope = collision(x + sign(hsp), y, [FLAG.slope]);
				if (_slope != noone && sign(_slope.image_xscale) == sign(hsp))
					{
					var _newspd = (_spd * bounce_speed_multiplier);
					var _newdir = (_slope.slope_type == SLOPE_TYPE.calculated_bounce)
						? bounce_angle(_dir, _slope.slope_angle) 
						: _slope.slope_normal;
					speed_set(lengthdir_x(_newspd, _newdir), lengthdir_y(_newspd, _newdir), false, false);
					//VFX
					var _side = hsp > 0 ? ((bbox_right - 1) - 1) : (bbox_left + 1);
					var _scale = clamp(_spd / 15, 0.5, 2);
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, _side, _slope.image_yscale > 0 ? (bbox_bottom - 1) : bbox_top, _scale, _slope.slope_normal, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -_scale, _scale);
					_vfx.vfx_blend = palette_color_get(palette_data, 0);
					}
				else
					{
					//Calculate VFX properties
					var _side = hsp > 0 ? ((bbox_right - 1) - 1) : (bbox_left + 1);
					var _angle = hsp > 0 ? 180 : 0;
					//Change the speed
					hsp = (-hsp * bounce_speed_multiplier);
					//VFX
					var _scale = clamp(_spd / 15, 0.5, 2);
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, _side, y, _scale, _angle, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -_scale, _scale);
					_vfx.vfx_blend = palette_color_get(palette_data, 0);
					}
				_result = TECH_RESULT.bounce;
				//Screenshake
				camera_shake(clamp(_spd * bounce_screen_shake_multiplier, 0, 10), 1);
				}
			//Slide
			else 
				{
				speed_set(0, 0, false, true);
				_result = TECH_RESULT.slide;
				}
			}
		}
	//Ceiling Collision / Edge Collision
	else if (vsp < 0 && (collision(x, y - 1, [FLAG.solid]) || (hsp != 0 && collision(x + sign(hsp), y - 1, [FLAG.solid]) && !collision(x + sign(hsp), y, [FLAG.solid]))))
		{
		if (_tech_input)
			{
			//Reset tech buffer
			tech_buffer = tech_lockout_time;
			//Ceiling tech
			state_set(PLAYER_STATE.teching);
			anim_set(my_sprites[$ "TechingC"]);
			_result = TECH_RESULT.success;
			}
		//Missed tech
		else
			{
			//Bounce
			if (_spd >= bounce_minimum_speed)
				{
				//Slopes
				var _slope = collision(x, y - 1, [FLAG.slope]);
				if (_slope != noone && sign(_slope.image_yscale) == -1)
					{
					var _newspd = (_spd * bounce_speed_multiplier);
					var _newdir = (_slope.slope_type == SLOPE_TYPE.calculated_bounce)
						? bounce_angle(_dir, _slope.slope_angle) 
						: _slope.slope_normal;
					speed_set(lengthdir_x(_newspd, _newdir), lengthdir_y(_newspd, _newdir), false, false);
					//VFX
					var _scale = clamp(_spd / 15, 0.5, 2);
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, _slope.image_xscale > 0 ? (bbox_right - 1) : bbox_left, bbox_top - 1, _scale, _slope.slope_normal, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -_scale, _scale);
					_vfx.vfx_blend = palette_color_get(palette_data, 0);
					}
				else
					{
					vsp = (-vsp * bounce_speed_multiplier);
					//VFX
					var _scale = clamp(_spd / 15, 0.5, 2);
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, x, bbox_top - 1, _scale, 270, "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -_scale, _scale);
					_vfx.vfx_blend = palette_color_get(palette_data, 0);
					}
				_result = TECH_RESULT.bounce;
				//Screenshake
				camera_shake(1, clamp(_spd * bounce_screen_shake_multiplier, 0, 10));
				}
			//Slide
			else
				{
				speed_set(0, 0, true, false);
				_result = TECH_RESULT.slide;
				}
			}
		}
	
	if (_result == TECH_RESULT.success)
		{
		//No speed
		speed_set(0, 0, false, false);
		//VFX
		var _vfx = vfx_create(spr_dust_tech, 1, 0, 22, x, y, 1, prng_number(0, 360));
		_vfx.important = true;
		//Reset tech
		tech_buffer = tech_lockout_time;
		}

	return _result;
}
/* Copyright 2023 Springroll Games / Yosi */