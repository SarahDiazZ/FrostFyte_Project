function ftilt_angled() {
	//Forward Tilt
	/*
	- Tilt the left stick up or down to get a different angle
	- The knockback angle, knockback, and scaling are different for each angle
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
				anim_sprite = spr_ftilt_angled;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 10;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					//Check angle
					var _val = stick_get_value(Lstick, DIR.vertical);
					//Up
					if (_val < -0.15)
						{
						anim_frame = 5;
						var _hitbox = hitbox_create_melee(40, -4, 0.8, 0.2, 6, 8, 0.75, 10, 50, 4, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, 20);
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						_hitbox.hitstun_scaling = 0.5;
						_hitbox.force_reeling = true;
						var _hitbox = hitbox_create_melee(76, -18, 0.3, 0.3, 8, 8, 0.75, 10, 50, 4, SHAPE.circle, 0);
						_hitbox.hit_sfx = snd_hit_electro;
						_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
						_hitbox.extra_hitlag = 19;
						_hitbox.shieldstun_scaling = 2;
						_hitbox.force_reeling = true;
						}
					//Down
					else if (_val > 0.15)
						{
						anim_frame = 8;
						var _hitbox = hitbox_create_melee(36, 10, 0.8, 0.2, 6, 8, 0.4, 10, 30, 4, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, -12);
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						_hitbox.hitstun_scaling = 0.5;
						_hitbox.can_lock = true;
						var _hitbox = hitbox_create_melee(76, 18, 0.3, 0.3, 8, 8, 0.4, 10, 30, 4, SHAPE.circle, 0);
						_hitbox.hit_sfx = snd_hit_electro;
						_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
						_hitbox.extra_hitlag = 19;
						_hitbox.shieldstun_scaling = 2;
						_hitbox.can_lock = true;
						}
					//Neutral
					else 
						{
						anim_frame = 2;
						var _hitbox = hitbox_create_melee(35, 8, 0.8, 0.2, 6, 9, 0.5, 10, 40, 4, SHAPE.rotation, 0, FLIPPER.sakurai);
						hitbox_sprite_angle_set(_hitbox, 0);
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						_hitbox.hitstun_scaling = 0.5;
						var _hitbox = hitbox_create_melee(74, 8, 0.3, 0.3, 8, 9, 0.5, 10, 40, 4, SHAPE.circle, 0, FLIPPER.sakurai);
						_hitbox.hit_sfx = snd_hit_electro;
						_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
						_hitbox.extra_hitlag = 19;
						_hitbox.shieldstun_scaling = 2;
						}
					attack_phase++;
					attack_frame = 6;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame++;
				if (attack_frame = 2)
					anim_frame++;
				
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 4 : 16;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame <= 8)
					anim_frame = 11;

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