function dash_attack_corrin() {
	//Dash Attack
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
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
				anim_sprite = spr_dash_attack_corrin;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 10;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 4)
					anim_frame = 3;
				if (attack_frame == 2)
					anim_frame = 4;
					
				if (attack_frame == 0)
					{
					anim_frame = 5;
			
					//Speed
					speed_set(sign(facing) * 8, 0, false, false);
			
					attack_phase++;
					attack_frame = 24;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame % 3 == 0)
					anim_frame++;
				if (anim_frame > 7)
					anim_frame = 5;
			
				//Stop at shields
				if (attack_connected(true, true))
					{
					speed_set(0, 0, false, false);
					}
			
				//Hitbox - every 4 frames
				if (attack_frame % 4 == 0 && attack_frame != 0)
					{
					//Reset the group, so it can hit multiple times despite being in the same hitbox group
					hitbox_group_reset(0);
					var _hitbox = hitbox_create_magnetbox(5, 0, 0.7, 0.3, 1, 1, 32, -5, 15, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hitlag_scaling = 0;
					}
				if (attack_frame == 0)
					{
					anim_frame = 8;
				
					attack_phase++;
					attack_frame = 8;
					//Final hit
					var _hitbox = hitbox_create_melee(0, 0, 0.7, 0.45, 5, 8.5, 0.6, 6, 50, 3, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					}
				break;
				}
			//Active -> Endlag
			case 2:
				{
				//Friction
				friction_gravity(0.7);
			
				//Animation
				if (attack_frame == 5)
					anim_frame = 9;
				
				if (attack_frame == 0)
					{
					anim_frame = 10;
			
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 18;
					}
				break;
				}
			//Finish
			case 3:
				{
				//Friction
				friction_gravity(ground_friction);
				
				//Animation
				if (attack_frame < 8)
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