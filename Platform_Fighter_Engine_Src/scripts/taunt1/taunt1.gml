///Taunt for character1
function taunt1() {
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;

	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction, 0.2, 2);
	
	//Respawn platform taunting
	var _respawn_platform = (respawn_platform_taunt_enable && array_contains(callback_passive, respawn_taunt_passive));
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_set(spr_taunt1, 0, 0.15);
				attack_frame = anim_calculate_length(spr_taunt1, 0.15);
				return;
				}
			case 0:
				{
				//Sound / Windbox
				if (attack_frame == 60)
					{
					game_sound_play(snd_hit_wind);
					hitbox_create_windbox(0, 6, 1.3, 0.7, 0, 2, 0, 20, SHAPE.square, 0, FLIPPER.from_player_center_horizontal, true, true, false, 5, false);
					}
			
				if (attack_frame == 0)
					{
					if (!_respawn_platform)
						{
						attack_stop();
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