function nspec_fireball() {
	//Neutral Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions / Cancels
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		aerial_drift();
		friction_gravity(air_friction, grav, max_fall_speed);
		}
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dspec_shine;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 16;
				reverse_b();
				return;
				}
			//Startup -> Throw
			case 0:
				{
				if (attack_frame == 12)
					{
					b_reverse();
					}
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					var _proj = hitbox_create_projectile(32, 0, 0.2, 0.2, 5, 1, 0, 0, 90, SHAPE.circle, 7, 7);
					_proj.vbounce = true;
					_proj.hbounce = true;
					_proj.bounce_multiplier = 0.8;
					_proj.grav = 0.4;
					_proj.overlay_sprite = spr_nspec_fireball_projectile;
					_proj.base_hitlag = 5;
					_proj.knockback_state = PLAYER_STATE.flinch;
					_proj.hit_vfx_style = HIT_VFX.normal_weak;
					_proj.can_lock = true;
				
					attack_phase++;
					attack_frame = 22;
					}
				break;
				}
			//Throw -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 3;
				if (attack_frame == 7)
					anim_frame = 4;
			
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