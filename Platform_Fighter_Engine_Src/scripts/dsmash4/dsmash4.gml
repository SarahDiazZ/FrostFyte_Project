function dsmash4() {
	//Down Smash
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dsmash4;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 6;
				return;
				}
			//Charging
			case 0:
				{
				//Animation (every 7 frames switch the sprite)
				if (charge % 7 == 0)
					{
					if (anim_frame == 1)
						anim_frame = 0;
					else
						{
						anim_frame = 1;
						
						//Shine VFX
						vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
						}
					}
			
				charge++;
				if ((charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special))) && attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 4;
					}
				break;
				}
			//Startup
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 3;
					
					//Pulling windbox
					hitbox_create_windbox(84, -6, 1, 1, 0, 3, 0, 5, SHAPE.square, 0, FLIPPER.toward_player_center_horizontal, true, true, false, 10, false);
				 
					attack_phase++;
					attack_frame = 5;
					}
				break;
				}
			//Active
			case 2:
				{
				//Mat Toss
				if (attack_frame == 0)
					{
					anim_frame = 4;
					
					//Hitstun Attack
					var _damage = calculate_smash_damage(12);
					var _hitbox = hitbox_create_melee(52, 0, 1.1, 0.7, _damage, 15, 0.2, 17, 85, 2, SHAPE.rotation, 1);
					_hitbox.hitstun_scaling = 1.2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					
					attack_frame = attack_connected() ? 13 : 30;
					
					attack_phase++;
					}
				break;
				}
			//Endlag
			case 3:
				{
				//Jump cancel on hit
				if (attack_connected() && cancel_jump_check())
					{
					return;
					}
				
				//Animation
				if (attack_frame == 25)
					anim_frame = 5;
				if (attack_frame == 19)
					anim_frame = 6;
				if (attack_frame == 12)
					anim_frame = 7;
				if (attack_frame == 8)
					anim_frame = 8;
				if (attack_frame == 4)
					anim_frame = 9;

				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */