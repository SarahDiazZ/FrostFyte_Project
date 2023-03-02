function grab_break_struggle_attack() {
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Phases
	if (run)
		{
		var _s = custom_attack_struct;
		var _id = custom_ids_struct;
		
		switch(_phase)
			{
			case PHASE.start:
				{
				//Invisible
				invisible = true;
				
				attack_frame = grab_break_struggle_time;
				
				//Invulnerability
				invulnerability_set(INV.invincible, attack_frame);
				
				//Variables
				_s.struggle_presses = 0;
				_id.struggle_opponent = noone;
				
				//Hitbox to hit third parties
				var _hitbox = hitbox_create_melee(0, 0, 2, 2, 5, 9, 0.1, 0, 45, attack_frame, SHAPE.circle, 0, FLIPPER.from_hitbox_center_horizontal);
				_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
				_hitbox.custom_hitstun = 20;
				//Needs to have 0 scaling so the players can't get out of sync
				_hitbox.hitlag_scaling = 0;
				_hitbox.can_be_parried = false;
				
				//VFX
				var _vfx = vfx_create(spr_hit_grab_break_struggle, 1, 0, 16, x, y, 2, prng_number(player_number, 360));
				_vfx.vfx_xscale *= prng_choose(1, -1, 1);
				_vfx.vfx_yscale *= prng_choose(2, -1, 1);
				_vfx.important = true;
				return;
				}
			//Mash buttons
			default:
				{
				//Reset the hitbox
				if (attack_frame % 12 == 0)
					{
					hitbox_group_reset(0);
					
					//VFX
					if (instance_exists(_id.struggle_opponent))
						{
						vfx_create_action_lines(10, mean(x, _id.struggle_opponent.x), mean(y, _id.struggle_opponent.y), prng_number(0, 10));
						}
					var _vfx = vfx_create(spr_hit_grab_break_struggle, 1, 0, 16, x + prng_number(player_number, 10, -10), y + prng_number(player_number, 10, -10), 2, prng_number(player_number, 360));
					_vfx.important = true;
					camera_shake(10);
					}
					
				//Button presses
				if (input_pressed(INPUT.attack) ||
					input_pressed(INPUT.special) ||
					input_pressed(INPUT.jump) ||
					input_pressed(INPUT.grab) ||
					input_pressed(INPUT.shield) ||
					input_pressed(INPUT.smash) ||
					input_pressed(INPUT.run) ||
					input_pressed(INPUT.taunt))
					{
					_s.struggle_presses += 1;
					
					//Deal small damage to opponents every 5 presses
					if (_s.struggle_presses % 5 == 0)
						{
						apply_damage(_id.struggle_opponent, 1);
						}
					}
				
				//Ending - check if you won or lost the struggle
				if (attack_frame == 0)
					{
					invisible = false;
					
					//Make sure the opponent is still there
					if (_id.struggle_opponent != noone &&
						instance_exists(_id.struggle_opponent))
						{
						if (_id.struggle_opponent.custom_attack_struct.struggle_presses >= _s.struggle_presses)
							{
							//Losing
							attack_stop(PLAYER_STATE.hitstun);
							var _dir = grab_break_struggle_angle;
							if (x < _id.struggle_opponent.x) then _dir = 180 - _dir;
							var _hsp = lengthdir_x(grab_break_struggle_speed, _dir);
							var _vsp = lengthdir_y(grab_break_struggle_speed, _dir);
							speed_set(_hsp, _vsp, false, false);
							knockback_spd = grab_break_struggle_speed;
							knockback_dir = _dir;
							is_reeling = true;
							state_frame = grab_break_struggle_hitstun;
							apply_damage(id, grab_break_struggle_damage);
							run = false;
							}
						else
							{
							//Winning - end the attack
							attack_stop();
							run = false;
							}
						}
					else
						{
						//Opponent left somehow
						attack_stop();
						run = false;
						}
					}
				break;
				}
			}
		}
		
	//No movement
}
/* Copyright 2023 Springroll Games / Yosi */