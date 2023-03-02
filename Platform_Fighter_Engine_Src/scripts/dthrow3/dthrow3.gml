function dthrow3() {
	//Downward Throw for character3
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
				anim_sprite = spr_dthrow3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 20;
			
				//Grant superarmor to avoid interruptions
				invulnerability_set(INV.superarmor, 20);
			
				//Move opponent above
				grabbed_id.x = x;
				grabbed_id.y = y - 30;
				grabbed_id.grab_hold_x = -4;
				grabbed_id.grab_hold_y = -60;
				
				player_move_to_back();
				return;
				}
			//Startup
			case 0:
				{
				//Move the grabbed opponent
				grab_snap_move();
				
				//Animation
				if (attack_frame == 17)
					anim_frame = 1;
				if (attack_frame == 11)
					anim_frame = 2;
				if (attack_frame == 4)
					{
					anim_frame = 3;
					grabbed_id.grab_hold_y = 10;
					}
				
				//Final hitbox
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 13;
					var _hitbox = hitbox_create_targetbox(0, 10, 1, 1, 9, 7.5, 0.6, 8, 80, 1, SHAPE.square, 0, grabbed_id);
					_hitbox.drift_di_multiplier = 1.5;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong3;
					var _vfx = vfx_create(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, 1, 90, "VFX_Layer_Below");
					_vfx.vfx_xscale = facing;
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 5;
				if (attack_frame = 6)
					anim_frame = 6;
				if (attack_frame = 3)
					anim_frame = 7;
			
				//Finish
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