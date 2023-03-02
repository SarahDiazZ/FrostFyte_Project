function dtilt_ryu() {
	//Down Tilt
	/*
	- Tap for the light version, hold for the heavy version
	- The light version cancels into specials on hit
	- You can buffer another dtilt during the endlag
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
				anim_sprite = spr_dtilt_ryu;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 7;
				
				hurtbox_anim_match();
				return;
				}
			//Startup
			case 0:
				{
				//Light
				if (attack_frame <= 3 && !input_held(INPUT.attack))
					{
					anim_frame = 1;
					attack_phase = 1;
					attack_frame = 15;
					
					var _hitbox = hitbox_create_melee(24, 16, 1.1, 0.3, 1, 3, 0.1, 2, 55, 2, SHAPE.square, 0);
					_hitbox.custom_hitstun = 20;
					_hitbox.techable = false;
					_hitbox.asdi_multiplier = 2; //Make it easier to get out of successive down tilts
					_hitbox.can_lock = true;
					}
				//Heavy
				else if (attack_frame == 0)
					{
					anim_frame = 1;
					attack_phase = 2;
					attack_frame = 21;
					
					//Ledge hitbox
					var _hitbox = hitbox_create_melee(24, 26, 1.1, 0.3, 6, 7, 0.3, 7, 45, 4, SHAPE.square, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.custom_hitstun = 23;
					_hitbox.hit_restriction = HIT_RESTRICTION.ledge_only;
					
					//Normal hitbox
					var _hitbox = hitbox_create_melee(24, 16, 1.1, 0.3, 6, 7, 0.3, 7, 45, 4, SHAPE.square, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.custom_hitstun = 23;
					_hitbox.shieldstun_scaling = 1.2;
					_hitbox.pre_hit_script = trip_pre_hit;
					}
				break;
				}
			//Light Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 13)
					anim_frame = 2;
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 7)
					anim_frame = 4;
				if (attack_frame == 4)
					anim_frame = 5;
				
				if (attack_connected())
					{
					//Special cancel
					if (allow_special_attacks()) then return;
					//Whiff lag
					if (attack_frame > 5) then attack_frame = 5;
					}
				
				if (attack_frame == 0)
					{
					//Buffered Dtilt
					if (input_held(INPUT.attack) && stick_tilted(Lstick, DIR.down))
						{
						attack_start(my_attacks[$ "Dtilt"]);
						run = false;
						}
					else
						{
						attack_stop(PLAYER_STATE.crouching);
						run = false;
						}
					}
				break;
				}
			//Heavy Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 19)
					anim_frame = 2;
				if (attack_frame == 15)
					anim_frame = 3;
				if (attack_frame == 10)
					anim_frame = 4;
				if (attack_frame == 5)
					anim_frame = 5;
				
				if (attack_connected())
					{
					//Special cancel
					if (allow_special_attacks()) then return;
					
					//Early cancel
					if (attack_frame <= 5)
						{
						if (cancel_any_action_check()) then return;
						}
					}
			
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
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */