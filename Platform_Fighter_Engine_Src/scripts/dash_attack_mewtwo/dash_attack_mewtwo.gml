function dash_attack_mewtwo() {
	//Dash Attack
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_dash_attack_mewtwo;
				anim_speed = 0;
				anim_frame = 0;
			
				//Initial slowdown
				speed_set(2 * facing, 0, false, false);
			
				attack_frame = 10;
				
				hurtbox_anim_match(spr_dash_attack_mewtwo_hurtbox);
				return;
				}
			//Startup
			case 0:
				{
				//Friction & gravity
				friction_gravity(slide_friction);
				
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 4)
					anim_frame = 3;
				if (attack_frame == 2)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					anim_frame = 5;
			
					attack_phase++;
					attack_frame = 10;
					
					speed_set(13 * facing, 0, false, false);
				
					var _hitbox = hitbox_create_melee(30, 0, 1, 0.4, 10, 8, 1, 8, 45, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.magic];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.4;
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
				break;
				}
			//Active
			case 1:
				{		
				//Friction & gravity
				friction_gravity(slide_friction);
				
				if (attack_frame == 8)
					{
					anim_frame = 6;
					var _hitbox = hitbox_create_melee(24, 0, 1, 0.3, 5, 6, 1, 6, 45, 8, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_weak, HIT_VFX.magic];
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.shieldstun_scaling = 0.4;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
				
					attack_phase++;
					attack_frame = 18;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Friction & gravity
				friction_gravity(ground_friction);
	
				//Animation
				if (attack_frame <= 12)
					anim_frame = 8;
				if (attack_frame <= 6)
					anim_frame = 9;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match(spr_dash_attack_mewtwo_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */