function item_bat_attack0() {
	//Item Bat Attack for character0
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction, grav, max_fall_speed);
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
				anim_sprite = spr_item_bat_attack0;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 45;
				
				item_visible = false;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 40)
					anim_frame = 1;
				if (attack_frame == 27)
					anim_frame = 2;
				if (attack_frame == 15)
					anim_frame = 3;
				if (attack_frame == 6)
					{
					anim_frame = 4;
					change_facing();
					invulnerability_set(INV.superarmor, 8);
					}
				if (attack_frame == 3)
					anim_frame = 5;
				
				if (attack_frame == 0)
					{
					anim_frame = 6;
			
					attack_phase++;
					attack_frame = 2;
					
					speed_set(6 * facing, 0, true, true);
					var _hitbox = hitbox_create_melee(32, 4, 1, 0.4, 41, 41, 0, 13, 40, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines, HIT_VFX.emphasis, HIT_VFX.slash_medium];
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.custom_shield_damage = 100;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 1)
					anim_frame = 7;
					
				if (attack_frame == 0)
					{
					anim_frame = 8;
				
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 9;
				if (attack_frame == 8)
					anim_frame = 10;
			
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
}
/* Copyright 2023 Springroll Games / Yosi */