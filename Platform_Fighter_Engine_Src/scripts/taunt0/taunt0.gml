function taunt0() {
	///Taunt for character0
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;

	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction);
	
	//Respawn platform taunting
	var _respawn_platform = (respawn_platform_taunt_enable && array_contains(callback_passive, respawn_taunt_passive));
	
	//Cancel in air
	if (!_respawn_platform)
		{
		if (run && cancel_air_check()) run = false;
		}

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_set(spr_taunt0, 0, 0.15);
				attack_frame = anim_calculate_length(spr_taunt0, 0.15);
				callback_add(callback_draw_end, taunt0_draw);
				return;
				}
			case 0:
				{
				//Sound
				if (attack_frame == 52)
					{
					game_sound_play(snd_taunt0);
					}
			
				//Taunt canceling
				if (attack_frame < 42)
					{
					if (run && check_walk()) run = false;
					if (run && check_dash()) run = false;
					if (run && check_crouch()) run = false;
					if (run && check_jump()) run = false;
					if (run && check_shield()) run = false;
					if (run && allow_ground_attacks()) run = false;
					if (run && allow_aerial_attacks()) run = false;
					if (run && allow_smash_attacks()) run = false;
					if (run && allow_special_attacks()) run = false;
					if (run && allow_grabs()) run = false;
					if (!run && state != PLAYER_STATE.attacking)
						{
						attack_stop_preserve_state();
						}
					}
			
				if (run && attack_frame == 0)
					{
					if (!_respawn_platform)
						{
						attack_stop(PLAYER_STATE.idle);
						}
					else
						{
						//Go back to the respawn state
						var _time_remaining = state_frame;
						attack_stop(PLAYER_STATE.respawning);
						state_frame = _time_remaining;
						}
					}
				break;
				}
			default: break;
			}
		}
		
	if (!_respawn_platform)
		{
		move();
		}
}
/* Copyright 2023 Springroll Games / Yosi */