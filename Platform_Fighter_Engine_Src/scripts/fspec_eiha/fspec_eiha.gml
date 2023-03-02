function fspec_eiha() {
	//Forward Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);

	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		aerial_drift();
		}

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec_eiha;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 16;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
					
				//B Reverse
				if (attack_frame == 12)
					{
					b_reverse();
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 30;
					var _proj = hitbox_create_projectile(16, -32, 0.2, 0.2, 2, 6, 0.6, 65, 36, SHAPE.circle, 11, 3);
					_proj.hit_vfx_style = HIT_VFX.magic;
					_proj.hit_sfx = snd_hit_weak2;
					_proj.destroy_on_blocks = true;
					_proj.post_hit_script = fspec_eiha_post_hit;
					hitbox_overlay_sprite_set(_proj, spr_fspec_eiha_projectile, 0, 0.5, 2, 0, c_white, 1, facing);
					
					//VFX
					if (on_ground())
						{
						var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x + (-16 * facing), (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = 2 * facing;
						}
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 3;
				if (attack_frame == 12)
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