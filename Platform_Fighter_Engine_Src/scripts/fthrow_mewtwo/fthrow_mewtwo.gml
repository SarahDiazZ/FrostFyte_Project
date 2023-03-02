function fthrow_mewtwo() {
	//Forward Throw
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fthrow_mewtwo;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 40;

				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 24);
				
				speed_set(0, 0, false, false);
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Launch hitbox
				if (attack_frame == 39)
					{
					anim_frame = 1;
					//Move the player to the correct position
					grabbed_id.x = x + (45 * facing);
					grabbed_id.y = y;
					var _hitbox = hitbox_create_targetbox(45, 0, 1, 1, 3, 13, 0, 4, 45, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.drift_di_multiplier = 0;
					_hitbox.di_angle = 0;
					_hitbox.asdi_multiplier = 0;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
					
				//Animation
				if (attack_frame == 31 ||
					attack_frame == 28 ||
					attack_frame == 22 ||
					attack_frame == 19)
					{
					anim_frame++;
					}
					
				//Projectiles
				if (attack_frame == 34 || attack_frame == 25)
					{
					anim_frame++;
					var _dir = 30;
					var _hsp = lengthdir_x(18, _dir);
					var _vsp = lengthdir_y(18, _dir);
					var _projectile = hitbox_create_projectile(32, -4, 0.4, 0.4, 1, 3, 0, 50, 60, SHAPE.circle, _hsp, _vsp);
					if (facing == -1) then _dir = 180 - _dir;
					hitbox_overlay_sprite_set(_projectile, spr_fthrow_mewtwo_projectile, 0, 1, 2, _dir, c_white, 1, 1);
					_projectile.destroy_on_blocks = false;
					_projectile.base_hitlag = 15;
					_projectile.asdi_multiplier = 0;
					_projectile.di_angle = 0;
					_projectile.drift_di_multiplier = 0;
					_projectile.hit_vfx_style = [HIT_VFX.normal_weak, HIT_VFX.magic];
					_projectile.hit_sfx = snd_hit_wind;
					_projectile.background_clear_allow = false;
					}
				if (attack_frame == 16)
					{
					anim_frame++;
					var _dir = 30;
					var _hsp = lengthdir_x(18, _dir);
					var _vsp = lengthdir_y(18, _dir);
					var _projectile = hitbox_create_projectile(32, -4, 0.4, 0.4, 4, 7, 0.85, 50, 60, SHAPE.circle, _hsp, _vsp);
					if (facing == -1) then _dir = 180 - _dir;
					hitbox_overlay_sprite_set(_projectile, spr_fthrow_mewtwo_projectile, 0, 1, 2, _dir, c_white, 1, 1);
					_projectile.destroy_on_blocks = false;
					_projectile.base_hitlag = 2;
					_projectile.hit_vfx_style = [HIT_VFX.normal_medium, HIT_VFX.magic];
					_projectile.hit_sfx = snd_hit_wind;
					}
				
				if (attack_frame == 14)
					anim_frame = 9;
				if (attack_frame == 9)
					anim_frame = 10;
				if (attack_frame == 5)
					anim_frame = 11;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Stay on the ground
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */