///@category Player Actions
/*
Allows the player to wall jump, and returns true if they do.
The specific conditions vary based on the <wall_jump_type>.
*/
function check_wall_jump() {
	switch(wall_jump_type)
		{
		case WALL_JUMP_TYPE.jump_press:
			{
			if (wall_jumps > 0 && wall_jump_timeout == 0)
				{
				if (!on_ground())
					{
					if (input_pressed(INPUT.jump, buffer_time_standard, false))
						{
						if (stick_tilted(Lstick, DIR.right))
							{
							var _y = (vsp > 0 ? y - vsp : y); //If the player is moving downwards, check further up the slope to make it easier to walljump
							var _slope = collision(x + wall_jump_check_distance_slope_x, _y + wall_jump_check_distance_slope_y, [FLAG.slope]);
							var _wall = (_slope != noone) ? noone : collision(x + wall_jump_check_distance, y, [FLAG.solid]);
							if (_wall != noone || (_slope != noone && abs(angle_difference(_slope.slope_angle, 270)) < wall_jump_check_slope_angle))
								{
								input_reset(INPUT.jump);
								state_set(PLAYER_STATE.wall_jump);
								speed_set(0, 0, false, false);
								facing = -1;
								state_frame = wall_jump_startup;
								wall_jumps--;
								var _vfx = vfx_create(spr_dust_wall_jump, 1, 0, 18, (bbox_right - 1), y, 2, 0);
								_vfx.vfx_xscale = -2;
								return true;
								}
							}
						else if (stick_tilted(Lstick, DIR.left))
							{
							var _y = (vsp > 0 ? y - vsp : y); //If the player is moving downwards, check further up the slope to make it easier to walljump
							var _slope = collision(x - wall_jump_check_distance_slope_x, _y + wall_jump_check_distance_slope_y, [FLAG.slope]);
							var _wall = (_slope != noone) ? noone : collision(x - wall_jump_check_distance, y, [FLAG.solid]);
							if (_wall != noone || (_slope != noone && abs(angle_difference(_slope.slope_angle, 270)) < wall_jump_check_slope_angle))
								{
								input_reset(INPUT.jump);
								state_set(PLAYER_STATE.wall_jump);
								speed_set(0, 0, false, false);
								facing = 1;
								state_frame = wall_jump_startup;
								wall_jumps--;
								var _vfx = vfx_create(spr_dust_wall_jump, 1, 0, 18, bbox_left, y, 2, 0);
								_vfx.vfx_xscale = 2;
								return true;
								}
							}
						}
					}
				}
			break;
			}
		case WALL_JUMP_TYPE.stick_flick:
			{
			if (can_wall_jump)
				{
				if (!on_ground())
					{
					if (stick_flicked(Lstick, DIR.left) && collision(x + wall_jump_check_distance, y, [FLAG.solid]))
						{
						state_set(PLAYER_STATE.wall_jump);
						speed_set(0, 0, false, false);
						facing = -1;
						state_frame = wall_jump_startup;
						wall_jumps--;
						return true;
						}
					if (stick_flicked(Lstick, DIR.right) && collision(x - wall_jump_check_distance, y, [FLAG.solid]))
						{
						state_set(PLAYER_STATE.wall_jump);
						speed_set(0, 0, false, false);
						facing = 1;
						state_frame = wall_jump_startup;
						wall_jumps--;
						return true;
						}
					}
				}
			break;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */