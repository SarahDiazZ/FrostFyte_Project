function final_smash0() {
	//Final Smash
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	var _blastzones = obj_stage_manager.blastzones;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_final_smash0_start;
				anim_speed = 0;
				anim_frame = 0;
				
				speed_set(0, 0, false, false);
				ignore_blastzones = true;
				
				//Store coordinates
				custom_attack_struct.final_smash_x = x;
				custom_attack_struct.final_smash_y = y;
				
				//Move the player to the foreground
				player_renderer_set(obj_player_renderer_foreground);
				player_move_to_front();
				
				//Camera
				with(obj_game)
					{
					cam_auto = false;
					if (camera_can_zoom())
						{
						cam_w_goal = camera_width_max;
						cam_h_goal = camera_height_max;
						}
					cam_x_goal = round(other.x - (cam_w div 2));
					cam_y_goal = round(other.y - (cam_h div 2));
					}
					
				callback_add(callback_draw_begin, final_smash0_draw);

				vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);

				final_smash_startup_script();
				
				attack_frame = 18;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 17)
					anim_frame = 1;
				if (attack_frame == 15)
					anim_frame = 2;
				if (attack_frame == 13)
					anim_frame = 3;
				if (attack_frame == 11)
					anim_frame = 4;
				if (attack_frame == 8)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
					
				//Move to the top of the screen
				if (attack_frame >= 0)
					{
					y = round(lerp(custom_attack_struct.final_smash_y, _blastzones.top - 64, 1 - (attack_frame / 18)));
					}
					
				//Camera zoom
				if (camera_can_zoom())
					{
					with(obj_game)
						{
						cam_w = lerp(cam_w, cam_w_goal, setting().camera_zoom_speed_out);
						cam_h = lerp(cam_h, cam_h_goal, setting().camera_zoom_speed_out);
						}
					}
				
				//Start the attack
				if (attack_frame == 0)
					{
					anim_alpha = 0;
					
					attack_phase++;
					attack_frame = 15;
					
					//Stop other players
					freeze_gameplay(15 + 18, false);
					}
				break;
				}
			//Active
			case 1:
				{
				//Hitbox
				if (attack_frame == 14)
					{
					//Hitbox
					var _hitbox = hitbox_create_melee(64, -24, 2, 2, 30, 3, 2, 18, 40, 14, SHAPE.circle, 0);
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.slash_strong];
					_hitbox.hit_sfx = snd_hit_explosion;
					_hitbox.hitstun_scaling = 0.4;
					}
					
				//Animation
				anim_sprite = spr_final_smash0;
				anim_speed = 1;
				anim_alpha = 1;
				
				//Position
				if (facing == 1)
					{
					x = round(lerp(_blastzones.left, _blastzones.right, 1 - (attack_frame / 15)));
					y = round(-0.25 * (x - custom_attack_struct.final_smash_x) + custom_attack_struct.final_smash_y);
					}
				else
					{
					x = round(lerp(_blastzones.right, _blastzones.left, 1 - (attack_frame / 15)));
					y = round(0.25 * (x - custom_attack_struct.final_smash_x) + custom_attack_struct.final_smash_y);
					}
				
				if (attack_frame == 0)
					{
					anim_alpha = 0;
					
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Endlag
			case 2:
				{
				if (attack_frame == 0)
					{
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					
					//Teleport back to center
					x = round(mean(_blastzones.left, _blastzones.right));
					y = _blastzones.top - 64;
					ignore_blastzones = false;
					
					//Reset camera
					with(obj_game)
						{
						cam_auto = true;
						}
					
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */