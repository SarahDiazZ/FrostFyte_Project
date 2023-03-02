function dair_yoshi() {
	//Down Aerial
	/*
	- Multihit spiking move
	- Has a hitbox when landing
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame=max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_try();
	aerial_drift();
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dair_yoshi;
				anim_speed = 0;
				anim_frame = 0;
		
				landing_lag = 20;
				speed_set(0, -1, true, true);
				attack_frame = 10;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 1;
				if (attack_frame == 2)
					anim_frame = 2;
					
				//Cancels
				if (cancel_ground_check()) then break;
				
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 16;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Hitbox loop
				if (attack_frame % 2 == 0 && attack_frame != 0)
					{
					//Animation
					anim_frame++;
					if (anim_frame > 6)
						anim_frame = 3;
				
					hitbox_group_reset_all();
					var _hitbox = hitbox_create_melee( 25, 30, 0.3, 0.4, 1, 2, 0, 2, 240, 2, SHAPE.circle, 0, FLIPPER.autolink_center);
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					var _hitbox = hitbox_create_melee(-25, 30, 0.3, 0.4, 1, 2, 0, 2, 300, 2, SHAPE.circle, 0, FLIPPER.autolink_center);
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					var _hitbox = hitbox_create_melee(  0, 28, 0.5, 0.7, 1, 2, 0, 2, 90, 2, SHAPE.circle, 0, FLIPPER.autolink_center);
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					}
				//Ground Cancel
				if (on_ground())
					{
					anim_frame = 2;
				
					attack_phase = 3;
					attack_frame = 12;
					hitbox_destroy_attached_all();
					var _hitbox = hitbox_create_melee(0, 10, 0.6, 0.4, 2, 9, 0.4, 4, 45, 4, SHAPE.square, 1, FLIPPER.sakurai);
					//VFX
					vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					}
				//Connecting hit
				else if (attack_frame == 0)
					{
					anim_frame = 7;
			
					attack_phase = 2;
					attack_frame = 20;
					//Draw in opponent for final hit
					var _hitbox = hitbox_create_magnetbox(0, 30, 0.5, 0.5, 0, 1, hsp * 4 * facing, 40, 10, 2, SHAPE.square, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 8;
				if (attack_frame == 12)
					anim_frame = 10;
				if (attack_frame == 6)
					anim_frame = 11;
			
				//Ground Cancel
				if (on_ground())
					{
					anim_frame = 2;
				
					attack_phase = 3;
					attack_frame = 12;
					hitbox_destroy_attached_all();
					var _hitbox = hitbox_create_melee(0, 10, 0.6, 0.4, 2, 10, 0.3, 4, 45, 4, SHAPE.square, 2, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					//VFX
					vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					}
				//Final Hit
				else if (attack_frame == 14)
					{
					anim_frame = 9;
				
					var _hitbox = hitbox_create_melee(0, 30, 0.6, 0.7, 6, 6, 0.7, 10, 45, 3, SHAPE.square, 2);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					}
				else if (attack_frame==0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			//Grounded Finish
			case 3:
				{
				friction_gravity(1, grav, max_fall_speed);
				//Animation
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
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */