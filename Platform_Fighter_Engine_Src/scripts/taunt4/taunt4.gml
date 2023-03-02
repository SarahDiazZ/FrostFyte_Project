function taunt4() {
	///Taunt for character4
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
				anim_sprite = spr_taunt4;
				anim_speed = 0;
				anim_frame = 0;
				
				attack_frame = 25;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 1;
				if (attack_frame == 15)
					anim_frame = 2;
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 6)
					anim_frame = 4;
				if (attack_frame == 3)
					anim_frame = 5;
					
				//Change into a random disguise
				if (attack_frame == 0)
					{
					//Sound
					game_sound_play(snd_taunt4);
					
					//Superarmor
					invulnerability_set(INV.superarmor, -1);
					
					//Smoke cloud
					var _vfx = vfx_create(spr_dust_poof, 1, 0, 28, x, y, 2, 0);
					_vfx.vfx_xscale *= prng_choose(0, -1, 1);
					_vfx.vfx_yscale *= prng_choose(1, -1, 1);
					
					//Random frame
					anim_frame = prng_choose_weighted
						(2, 
							[
							6,	1,
							7,	1,
							8,	1,
							9,	1,
							10,	1,
							11,	5, //50% chance of getting tree
							],
						);
					
					//Tree hitbox
					if (anim_frame == 11)
						{
						var _hitbox = hitbox_create_melee(0, -32, 0.5, 2, 7, 9, 1, 13, 90, 2, SHAPE.square, 0);
						_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
						}
					
					attack_phase++;
					attack_frame = 20; //Minimum disguise time
					}
				break;
				}
			//Disguise
			case 1:
				{
				//Cancel
				if (attack_frame <= 0)
					{
					if (!input_held(INPUT.taunt))
						{
						invulnerability_set(INV.normal, 0);
						
						//Smoke cloud
						var _vfx = vfx_create(spr_dust_poof, 1, 0, 28, x, y, 2, 0);
						_vfx.vfx_xscale *= prng_choose(0, -1, 1);
						_vfx.vfx_yscale *= prng_choose(1, -1, 1);
					
						anim_frame = 12;
					
						attack_phase++;
						attack_frame = 15;
						}
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 13;
				if (attack_frame == 5)
					anim_frame = 14;
					
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
			}
		}
	
	if (!_respawn_platform)
		{
		move_grounded();
		}
}
/* Copyright 2023 Springroll Games / Yosi */