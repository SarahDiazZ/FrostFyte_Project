///@category Player Standard States
/*
This script contains the default Helpless state characters are given.

The Helpless state is a version of the Aerial state that prevents players from doing most actions, and is normally used to balance recovery moves.
*/
function standard_helpless() {
	//Contains the standard actions for the helpless state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Helpless"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Friction / Gravity
			friction_gravity(air_friction, grav, max_fall_speed);

			//Helpless Drift
			//If stick is past threshold
			if (stick_tilted(Lstick))
				{
				//Drift cannot be used to speed up knockback to high speeds
				var _val = sign(stick_get_value(Lstick, DIR.horizontal));
				if (_val == sign(hsp))
					{
					if (abs(hsp + helpless_accel * _val) < helpless_max_speed)
						{
						hsp += helpless_accel * _val;
						}
					}
				else
					{
					hsp += helpless_accel * _val;
					}
				}

			//Hard Landing
			if (run && check_landing())
				{
				state_frame = landing_lag;
				run = false;
				}

			//Ledge
			if (run && check_ledge_grab()) then run = false;

			//Wall Jumping
			if (run)
				{
				if (wall_jump_type == WALL_JUMP_TYPE.jump_press)
					{
					if (run && check_wall_cling()) then run = false;
					if (run && check_wall_jump()) then run = false;
					}
				}

			//Fastfalling increases the landing lag
			if (run)
				{
				if (fastfall_try())
					{
					landing_lag += helpless_fastfall_lag_increase;
					}
				}

			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */