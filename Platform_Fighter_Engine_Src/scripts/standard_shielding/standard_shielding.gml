///@category Player Standard States
/*
This script contains the default Shielding state characters are given.

The Shielding state is for players who are shielding, which is only possible when <shield_type> is set to SHIELD_TYPE.perfect_shield_start or SHIELD_TYPE.parry_shield.
The exact actions players can perform when shielding is different for each shield type.
*/
function standard_shielding() {
	//Contains the standard actions for the shielding state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Shield"]);
			//Reset shieldstun
			shieldstun = 0;
			//Shield Hurtbox
			switch(shield_type)
				{
				case SHIELD_TYPE.perfect_shield_start:
					{
					if (shield_poking_enable)
						{
						if (instance_exists(hurtbox_shield)) then instance_destroy(hurtbox_shield);
						hurtbox_shield = hurtbox_create(0, 0, 1, 1, -1, SHAPE.circle, INV.powershielding);
						hurtbox_shield.hurtbox_type = HURTBOX_TYPE.shield;
						
						//The player's hurtbox can also powershield at the very start
						invulnerability_set(INV.powershielding, 1);
						}
					else
						{
						invulnerability_set(INV.powershielding, 1);
						}
					break;
					}
				case SHIELD_TYPE.parry_shield:
					{
					if (shield_poking_enable)
						{
						if (instance_exists(hurtbox_shield)) then instance_destroy(hurtbox_shield);
						hurtbox_shield = hurtbox_create(0, 0, 1, 1, -1, SHAPE.circle, INV.shielding);
						hurtbox_shield.hurtbox_type = HURTBOX_TYPE.shield;
						invulnerability_set(INV.shielding, 1);
						}
					else
						{
						invulnerability_set(INV.shielding, 1);
						}
					break;
					}
				}
			//Sound
			game_sound_play(snd_shield_start);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			friction_gravity(ground_friction, grav, max_fall_speed);
	
			//Change to aerial state
			if (run && check_aerial()) then run = false;
	
			//Check shield type
			switch(shield_type)
				{
				case SHIELD_TYPE.perfect_shield_start:
					{
					//Shield Health
					shield_hp -= shield_depeletion_rate;
					//Shield Stun
					shieldstun = max(--shieldstun, 0);
					if (run && shieldstun <= 0)
						{
						//Shield Release
						if (run && state_frame == 0 && !input_held(INPUT.shield, 0))
							{
							input_reset(INPUT.shield);
							state_set(PLAYER_STATE.shield_release);
							state_frame = shield_release_time;
							run = false;
							}
						//Wavedash Cancel
						if (shield_into_wavedash && 
							run	&& 
							state_frame > 0	&& 
							input_pressed(INPUT.jump) && 
							check_airdodge())
							{
							run = false;
							}
						//Jump Cancel - Reset the input from the buffer so it doesn't waveland cancel
						if (run && check_jump())
							{
							input_reset(INPUT.shield);
							run = false;
							}
						//Rolling Cancel
						if (run && check_rolling_hold()) then run = false;
						//Spot Dodge
						if (run && check_spot_dodge()) then run = false;
						//Items
						if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
							item_system_type == ITEM_SYSTEM_TYPE.simplified)
							{
							if (run && allow_item_throws()) then run = false;
							}
						//Grab Cancel
						if (run && allow_grabs()) then run = false;
						//Shield Shifting
						if (run)
							{
							var _stick = stick_choose_by_input(INPUT.shield);
							var _amount = (stick_get_distance(_stick) * shield_shift_amount);
							shield_shift_x = lengthdir_x(_amount, stick_get_direction(_stick));
							shield_shift_y = lengthdir_y(_amount, stick_get_direction(_stick));
							}
						}
					//Shield Break
					if (run && shield_hp <= 0)
						{
						shield_hp = shield_break_reset_hp;
						state_set(PLAYER_STATE.shield_break);
						state_frame = shield_break_time_min + (damage * shield_break_multiplier);
						speed_set(0, -shield_break_launch, true, false);
						//VFX
						for(var m = 0; m < 24; m++)
							{
							with(instance_create_layer(x, y, layer, obj_shield_break_particle))
								{
								var _dir = m * 15;
								var _len = 33 + (17 * sin(m));
								hsp = lengthdir_x(_len, _dir);
								vsp = lengthdir_y(_len, _dir);
								vfx_sprite = spr_hit_shield_break_particle;
								vfx_speed = 0;
								vfx_frame = m % 6;
								lifetime = prng_number(m % (prng_channels - 1), 45, 25);
								vfx_xscale = prng_number((m + 2) % (prng_channels - 1), 15, 5) / 10;
								vfx_yscale = vfx_xscale;
								vfx_angle = m * 15;
								total_life = lifetime;
								fade = true;
								}
							}
						camera_shake(4);
						vfx_create(spr_hit_final_hit, 1, 0, 36, x, y, 1, 45);
						run = false;
						}
					//Invulnerability
					if (run)
						{
						if (shield_poking_enable)
							{
							if (state_frame == 0)
								{
								hurtbox_inv_set(hurtbox_shield, INV.shielding, 1);
								
								//The player's permanent hurtbox has no special invulnerability
								invulnerability_set(INV.normal, 0);
								}
							else
								{
								hurtbox_inv_set(hurtbox_shield, INV.powershielding, 1);
								}
							}
						else
							{
							if (state_frame == 0)
								{
								invulnerability_set(INV.shielding, 1);
								}
							else
								{
								invulnerability_set(INV.powershielding, 1);
								}
							}
						}
					break;
					}
				//Parry (different state)
				case SHIELD_TYPE.parry_press:
					{
					//<check_shield>
					break;
					}
				//Ultimate
				case SHIELD_TYPE.parry_shield:
					{
					//Shield Health
					shield_hp -= shield_depeletion_rate;
					//Shield Stun
					shieldstun = max(--shieldstun, 0);
					if (run && shieldstun <= 0)
						{
						//Shield Release
						if (run && state_frame == 0 && !input_held(INPUT.shield, 0))
							{
							input_reset(INPUT.shield);
							state_set(PLAYER_STATE.shield_release);
							invulnerability_set(INV.parry_shield, parry_ult_window);
							state_frame = shield_release_time;
							run = false;
							}
						//Jump Cancel - Reset the input from the buffer so it doesn't waveland cancel
						if (run && check_jump())
							{
							input_reset(INPUT.shield);
							run = false;
							}
						//Rolling Cancel
						if (run && check_rolling_hold()) then run = false;
						//Spot Dodge
						if (run && check_spot_dodge()) then run = false;
						//Items
						if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
							item_system_type == ITEM_SYSTEM_TYPE.simplified)
							{
							if (run && allow_item_throws()) then run = false;
							}
						//Grab Cancel
						if (run && allow_grabs()) then run = false;
						//Shield Shifting
						if (run)
							{
							var _stick = stick_choose_by_input(INPUT.shield);
							var _amount = (stick_get_distance(_stick) * shield_shift_amount);
							shield_shift_x = lengthdir_x(_amount, stick_get_direction(_stick));
							shield_shift_y = lengthdir_y(_amount, stick_get_direction(_stick));
							}
						}
					//Shield Break
					if (run && shield_hp <= 0)
						{
						shield_hp = shield_break_reset_hp;
						state_set(PLAYER_STATE.shield_break);
						state_frame = shield_break_time_min + (damage * shield_break_multiplier);
						speed_set(0, -shield_break_launch, true, false);
						//VFX
						for(var m = 0; m < 24; m++)
							{
							with(instance_create_layer(x, y, layer, obj_shield_break_particle))
								{
								var _dir = m * 15;
								var _len = 33 + (17 * sin(m));
								hsp = lengthdir_x(_len, _dir);
								vsp = lengthdir_y(_len, _dir);
								vfx_sprite = spr_hit_shield_break_particle;
								vfx_speed = 0;
								vfx_frame = m % 6;
								lifetime = prng_number(m % (prng_channels - 1), 45, 25);
								vfx_xscale = prng_number((m + 2) % (prng_channels - 1), 15, 5) / 10;
								vfx_yscale = vfx_xscale;
								vfx_angle = m * 15;
								total_life = lifetime;
								fade = true;
								}
							}
						camera_shake(4);
						vfx_create(spr_hit_final_hit, 1, 0, 36, x, y, 1, 45);
						run = false;
						}
					//Invulnerability
					if (run)
						{
						if (shield_poking_enable)
							{
							//The player's permanent hurtbox has no special invulnerability
							invulnerability_set(INV.normal, 0);
							hurtbox_inv_set(hurtbox_shield, INV.shielding, 1);
							}
						else
							{
							invulnerability_set(INV.shielding, 1);
							}
						}
					break;
					}
				default: break;
				}
	
			jostle_players();
			move_grounded();
			break;
			}
		case PLAYER_STATE_PHASE.stop:
			{
			//Sound
			game_sound_play(snd_shield_start);
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */