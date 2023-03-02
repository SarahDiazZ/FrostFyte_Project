function nspec_hadoken() {
	//Neutral Special
	/*
	- Tap the button for a fast but weak fireball
	- Hold the button for a strong but slow fireball
	- Hold shield to not create a projectile
	*/
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
				anim_sprite = spr_nspec_hadoken;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 13;
				
				reverse_b();
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Throw
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				if (attack_frame == 8)
					{
					b_reverse();
					}
					
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 2)
					anim_frame = 3;
				
				if (attack_frame == 0)
					{
					anim_frame = 4;
					
					if (!on_ground())
						{
						speed_set(hsp / 2, -3, false, false);
						}
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					
					//Melee hit
					var _hitbox = hitbox_create_melee(32, 0, 0.6, 0.6, 4, 11, 0, 8, 0, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.techable = false;
					_hitbox.di_angle = 0;
					_hitbox.custom_hitstun = 15;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox.can_lock = true;
					var _hitbox = hitbox_create_melee(32, 0, 0.6, 0.6, 4, 6, 0.5, 8, 50, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					
					if (!input_held(INPUT.shield))
						{
						//Create the projectile 1 frame later, so if the melee hit lands the projectile will spawn after the hitlag
						attack_phase++;
						attack_frame = 33;
						}
					else
						{
						//Shield cancel
						attack_phase = 2
						attack_frame = 15;
						}
					}
				break;
				}
			//Throw -> Finish
			case 1:
				{
				//Projectile
				if (attack_frame == 32)
					{
					//EX
					if (ex_move_is_activated())
						{
						var _new = entity_create(x + (48 * facing), y, obj_nspec_hadoken, "VFX_Layer");
						var _c = _new.custom_entity_struct;
						_c.overlay_frame = 0;
						_c.overlay_speed = 0.4;
						_c.lifetime = 360;
						_c.type = 2;
						_new.facing = facing;
						_new.hsp = 1 * facing;
						_new.image_xscale = 2 * facing;
						_new.image_yscale = 2;
						}
					//Light
					else if (!input_held(INPUT.special))
						{
						var _new = entity_create(x + (48 * facing), y, obj_nspec_hadoken, "VFX_Layer");
						var _c = _new.custom_entity_struct;
						_c.overlay_frame = 1;
						_c.overlay_speed = 0.4;
						_c.lifetime = 120;
						_c.type = 0;
						_new.facing = facing;
						_new.hsp = 3 * facing;
						_new.image_xscale = 2 * facing;
						_new.image_yscale = 2;
						}
					//Heavy
					else
						{
						var _new = entity_create(x + (48 * facing), y, obj_nspec_hadoken, "VFX_Layer");
						var _c = _new.custom_entity_struct;
						_c.overlay_frame = 2;
						_c.overlay_speed = 0.6;
						_c.lifetime = 90;
						_c.type = 1;
						_new.facing = facing;
						_new.hsp = 7 * facing;
						_new.image_xscale = 2 * facing;
						_new.image_yscale = 2;
						}
						
					//Cooldown
					attack_cooldown_set(50);
					}
					
				//Animation
				if (attack_frame == 31)
					anim_frame = 5;
				if (attack_frame == 25)
					anim_frame = 6;
				if (attack_frame == 20)
					anim_frame = 7;
				if (attack_frame == 14)
					anim_frame = 8;
				if (attack_frame == 7)
					anim_frame = 9;
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Shield Cancel -> Finish
			case 2:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 6;
				if (attack_frame == 11)
					anim_frame = 7;
				if (attack_frame == 7)
					anim_frame = 8;
				if (attack_frame == 3)
					anim_frame = 9;
			
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