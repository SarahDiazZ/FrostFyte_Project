///Taunt for character3
function taunt3() {
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
				anim_set(spr_taunt3, 0, 0.3);
				attack_frame = anim_calculate_length(spr_taunt3, 0.3);
				return;
				}
			case 0:
				{
				if (attack_frame == 26)
					{
					vfx_create(spr_shine_attack, 0.5, 0, 8, x + (16 * facing), y - 8, 1, 0);
					}
				
				if (attack_frame == 0)
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
		move_grounded();
		}
}
/* Copyright 2023 Springroll Games / Yosi */