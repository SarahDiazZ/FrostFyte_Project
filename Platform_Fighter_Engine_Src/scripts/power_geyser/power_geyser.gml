function power_geyser() {
	/*
	- Creates a large geyser of energy in front, hitting opponents diagonally upwards
	*/
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
				anim_sprite = spr_power_geyser;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 20;
				
				hurtbox_anim_match(spr_power_geyser_hurtbox);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 1;
				if (attack_frame == 16)
					anim_frame = 2;
				if (attack_frame == 13)
					anim_frame = 3;
				if (attack_frame == 10)
					anim_frame = 4;
				if (attack_frame == 8)
					anim_frame = 5;
					
				if (attack_frame == 0)
					{
					anim_frame = 6;
					attack_phase++;
					attack_frame = 9;
					
					game_sound_play(snd_hit_explosion4);
					
					invulnerability_set(INV.superarmor, 9);
					
					//Base
					var _hitbox = hitbox_create_melee(88, -2, 2.4, 0.9, 20, 9, 1, 15, 75, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_explosion3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Pillar center
					var _hitbox = hitbox_create_melee(112, -102, 0.5, 2.3, 20, 9, 1, 15, 75, 4, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 168);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_explosion3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Pillar sides
					var _hitbox = hitbox_create_melee(118, -135, 1.5, 3.9, 10, 8, 0.9, 10, 75, 4, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 168);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_explosion3;
					
					//VFX
					var _vfx = vfx_create(spr_power_geyser_explosion, 1, 0, 48, x + (88 * facing), y + 24, 1.5, 0);
					_vfx.vfx_xscale = facing * 1.5;
					_vfx.important = true;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 7;
				if (attack_frame == 4)
					anim_frame = 8;
					
				if (attack_frame == 5)
					{
					//Base
					var _hitbox = hitbox_create_melee(88, -2, 1.4, 0.9, 10, 8, 1, 5, 75, 5, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_explosion3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Pillar center
					var _hitbox = hitbox_create_melee(112, -102, 0.5, 2.3, 10, 8, 1, 5, 75, 5, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 168);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_explosion3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Pillar sides
					var _hitbox = hitbox_create_melee(118, -135, 1.5, 3.9, 5, 7, 0.9, 5, 75, 5, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 168);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_explosion3;
					}
				
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 40;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 9;
				if (attack_frame == 10)
					anim_frame = 10;
			
				if (attack_frame == 0)
					{
					attack_stop();
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();

	//Match hurtbox
	if (run)
		{
		hurtbox_anim_match(spr_power_geyser_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */