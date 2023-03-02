function fspec_cross_slash() {
	//Forward Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);

	//Move to the front
	player_move_to_front();

	//Phases
	if (run)
		{
		var _limit_version = false;
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec_cross_slash;
				anim_speed = 0;
				anim_frame = 0;
				
				attack_frame = 8;
				return;
				}
			//First Startup
			case 0:
				{
				//Speed
				friction_gravity(0.7, 0.3, max_fall_speed);
				
				if (attack_frame == 0)
					{
					//Speed
					if (!on_ground()) then speed_set(0, -2, true, false);
					
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 30;
					
					var _hitbox = hitbox_create_magnetbox(56, 0, 0.8, 0.8, 4, 5, 0, -1, 10, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					
					if (_limit_version)
						{
						//VFX
						var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = 2 * facing;
						camera_shake(4);
						}
					}
				break;
				}
			//First Endlag
			case 1:
				{
				//Speed
				friction_gravity(0.7, 0.3, max_fall_speed);
				
				//Animation
				if (attack_frame == 27)
					anim_frame = 2;
				if (attack_frame == 22)
					anim_frame = 3;
				if (attack_frame == 16)
					anim_frame = 4;
				
				//Second part
				if (attack_frame < 25 && ((attack_connected(true) && input_pressed(INPUT.special)) || _limit_version))
					{
					//Speed
					if (!on_ground()) then speed_set(0, -2, false, false);
					
					//Reset
					any_hitbox_has_been_blocked = false;
					any_hitbox_has_hit = false;
					input_reset(INPUT.special);
					
					anim_frame = 5;
					attack_frame = 17;
					attack_phase++;
					
					hitbox_group_reset(0);
					var _hitbox = hitbox_create_magnetbox(56, 0, 0.8, 0.8, 4, 5, 3, -1, 10, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					
					if (_limit_version) then camera_shake(5);
					break;
					}
					
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Second Endlag
			case 2:
				{
				//Speed
				friction_gravity(0.7, 0.3, max_fall_speed);
				
				//Animation
				if (attack_frame == 14)
					anim_frame = 6;
				if (attack_frame == 7)
					anim_frame = 7;
				
				//Third part
				if (attack_frame < 12 && ((attack_connected(true) && input_pressed(INPUT.special)) || _limit_version))
					{
					anim_frame = 8;
					attack_frame = 26;
					attack_phase++;
					
					hitbox_group_reset(0);
					var _hitbox = hitbox_create_magnetbox(56, 0, 0.8, 0.8, 4, 5, 3, -1, 10, 1, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					
					if (_limit_version) then camera_shake(5);
					}
					
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Third active
			case 3:
				{
				if (attack_frame == 24)
					{
					anim_frame = 9;
					
					hitbox_group_reset(0);
					var _hitbox = hitbox_create_magnetbox(56, 0, 1, 1, 4, 5, 0, -1, 5, 1, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_strong2;
					
					if (_limit_version) then camera_shake(5);
					}
				
				if (attack_frame == 22)
					{
					anim_frame = 10;
					
					if (_limit_version)
						{
						var _hitbox = hitbox_create_melee(56, 0, 1, 1, 8, 6, 2, 24, 35, 3, SHAPE.square, 1);
						_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.lines, HIT_VFX.normal_strong, HIT_VFX.emphasis];
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.di_angle = 5;
						}
					else
						{
						var _hitbox = hitbox_create_melee(56, 0, 1, 1, 8, 6, 0.8, 14, 45, 3, SHAPE.square, 1);
						_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.lines, HIT_VFX.normal_strong];
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.hitstun_scaling = 0.5;
						}
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
					
				//Falling
				if (attack_frame <= 15)
					{
					if (!on_ground())
						{
						friction_gravity(0, 0.2, max_fall_speed);
						aerial_drift();
						}
					}
				if (attack_frame == 20)
					anim_frame = 11;
				if (attack_frame == 14)
					anim_frame = 12;
				if (attack_frame == 6)
					anim_frame = 13;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */