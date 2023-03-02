function fair4() {
	//Forward Aerial
	/*
	- Hold the button to charge the attack longer
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
	aerial_drift();
	//Cancels
	if (run && cancel_ground_check()) then run = false;
	//Main Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_fair4;
				anim_frame = 0;
				anim_speed = 0;
				
				charge = 0;
				
				landing_lag = 12;
				attack_frame = 23;
				speed_set(0, -1, true, true);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 17)
					anim_frame = 1;
				if (attack_frame == 11)
					anim_frame = 2;
				if (attack_frame == 5)
					anim_frame = 3;
  
				//Next phase - Max charge is 10
				if (attack_frame <= 10)
					{
					if ((!input_held(INPUT.attack) && !input_held(INPUT.smash)) || attack_frame == 0 || charge >= 10)
						{
						anim_frame = 4;
						
						if (charge < 10)
							{
							var _damage = floor(lerp(6, 12, charge / 10));
							//Normal Hitbox
							var _hitbox = hitbox_create_melee(42, 3, 1.3, 0.55, _damage, 8, 1.1, 12, 45, 4, SHAPE.circle, 0, FLIPPER.sakurai);
							_hitbox.knockback_state = PLAYER_STATE.balloon;
							_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
							_hitbox.hit_sfx = snd_hit_strong2;
							_hitbox.shieldstun_scaling = 0.75;
							_hitbox.hitstun_scaling = 0.6;
							}
						else
							{
							//Fully Charged
							var _hitbox = hitbox_create_melee(42, 3, 1.3, 0.55, 12, 9, 1.2, 12, 45, 4, SHAPE.circle, 0, FLIPPER.sakurai);
							_hitbox.knockback_state = PLAYER_STATE.balloon;
							_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
							_hitbox.hit_sfx = snd_hit_strong;
							_hitbox.hitstun_scaling = 0.6;
							}
						attack_phase++;
						attack_frame = 4;
						}
					else
						{
						charge++;
						if (charge == 10)
							{
							vfx_create(spr_shine_fastfall, 1, 0, 14, x - (32 * facing), y + 48, 2, 0);
							}
						}
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 2)
					anim_frame = 5;
			
				if (attack_frame == 0)
					{
					anim_frame = 6;	
					
					//Whiff lag
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 20;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 15)
					anim_frame = 7;
				if (attack_frame == 10)
					{
					anim_frame = 8;	
					//Autocancel
					landing_lag = 3;
					}
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			}
		}
	//Movement
	move();
}

/* Copyright 2023 Springroll Games / Yosi */