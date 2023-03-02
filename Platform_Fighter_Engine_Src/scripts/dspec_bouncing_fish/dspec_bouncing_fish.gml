function dspec_bouncing_fish() {
	//Down Special
	/*
	- Press the special button to use the attack faster
	- Hitting an opponent causes the user to bounce backwards
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions
	aerial_drift_momentum();
	friction_gravity(0.04, 0.6, 10);
	//Main Phases
	if (run)
		{
		switch(_phase)
			{
			//Initialize
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dspec_bouncing_fish;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_cooldown_set(60);
				speed_set(9 * facing, -8, false, false);
				attack_frame = 36;
				landing_lag = 10;
				//Shine VFX
				vfx_create(spr_shine_attack, 1, 0, 8, x, y, 1, 45);
				return;
				}
			//Startup
			case 0:
				{
				if (run && cancel_ground_check()) break;

				if (attack_frame == 30)
					anim_frame = 1;
				if (attack_frame == 24)
					anim_frame = 2;
				if (attack_frame == 18)
					anim_frame = 3;
				if (attack_frame == 11)
					anim_frame = 4;
				if (attack_frame == 6)
					anim_frame = 5;
				if (attack_frame == 3)
					anim_frame = 6;
				
				if (attack_frame == 0 || (attack_frame < 20 && input_pressed(INPUT.special)))
					{
					//Animation
					anim_frame = 7;
				
					attack_frame = 20;
					attack_phase++;
					speed_set(0, -1, true, true);
					var _hitbox = hitbox_create_melee(50, -24, 0.5, 0.5, 12, 5, 1, 10, 45, 2, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = [HIT_VFX.splash, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					}
				break;
				}
			//Ending
			case 1:
				{
				if (attack_frame == 19)
					{
					//Animation
					anim_frame = 8;
				
					var _hitbox = hitbox_create_melee(50, 0, 0.7, 1, 12, 5, 1, 10, 45, 5, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = [HIT_VFX.splash, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				
				if (run && cancel_ground_check()) break;
			
				//Bounce off
				if (attack_connected(true))
					{
					speed_set(-6 * facing, -9, false, false);
					facing = -facing;
					anim_frame = 6;
					attack_frame = 30;
					attack_phase++;
					break;
					}
				
				//Animation
				if (attack_frame == 14)
					anim_frame = 9;
				if (attack_frame == 9)
					anim_frame = 10;
				if (attack_frame == 4)
					anim_frame = 11;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			//Bounce
			case 2:
				{
				if (run && cancel_ground_check()) break;
			
				//Animation
				if (attack_frame == 25)
					anim_frame = 7;
				if (attack_frame == 20)
					anim_frame = 8;
				if (attack_frame == 15)
					anim_frame = 9;
				if (attack_frame == 10)
					anim_frame = 10;
				if (attack_frame == 5)
					anim_frame = 11;
				
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