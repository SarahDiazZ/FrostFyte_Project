///@category Player Standard States
/*
This script contains the default Wall Cling state characters are given.

The Wall Cling state is for players holding on to the side of a wall.
Wall clinging can be enabled or disabled per character.
The exact specifics of wall clinging is dependent on the <wall_jump_type>.
*/
function standard_wall_cling() {
	//Contains the standard actions for the wall cling state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "WallC"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			switch(wall_jump_type)
				{
				case WALL_JUMP_TYPE.jump_press:
					{
					if (run && !input_held(INPUT.jump) && wall_jumps > 0 && wall_jump_timeout == 0)
						{
						state_set(PLAYER_STATE.wall_jump);
						speed_set(0, 0, false, false);
						state_frame = wall_jump_startup;
						wall_jumps--;
		
						wall_cling_timeout = wall_cling_normal_timeout;
				
						//VFX
						if (collision(x + wall_jump_check_distance, y, [FLAG.solid]))
							{
							var _vfx = vfx_create(spr_dust_wall_jump, 1, 0, 18, (bbox_right - 1), y, 2, 0);
							_vfx.vfx_xscale = -2;
							}
						else if (collision(x - wall_jump_check_distance, y, [FLAG.solid]))
							{
							var _vfx = vfx_create(spr_dust_wall_jump, 1, 0, 18, bbox_left, y, 2, 0);
							_vfx.vfx_xscale = 2;
							}
		
						run = false;
						}
					//If the time ran out, you are not holding the button, or there is no longer a wall
					if (run && (state_time == wall_cling_time_max || 
						!input_held(INPUT.jump) ||
						!collision(x + (wall_cling_check_distance * -facing), y, [FLAG.solid])))
						{
						state_set(PLAYER_STATE.aerial);
						wall_cling_timeout = wall_cling_normal_timeout;
						}
					break;
					}
				case WALL_JUMP_TYPE.stick_flick:
					{
					if (run && check_wall_jump()) run = false;
					if (run && (state_time == wall_cling_time_max ||
						(!stick_tilted(Lstick, DIR.right) && collision(x + wall_cling_check_distance, y, [FLAG.solid])) ||
						(!stick_tilted(Lstick, DIR.left) && collision(x - wall_cling_check_distance, y, [FLAG.solid]))))
						{
						state_set(PLAYER_STATE.aerial);
						wall_cling_timeout = wall_cling_normal_timeout;
						}
					break;
					}
				}
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */