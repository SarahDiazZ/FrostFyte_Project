///@category Hurtboxes
///@param {id} hitbox		The attacking hitbox
///@param {id] hurtbox		The hurtbox being hit
/*
Standard script for when an <obj_hitbox_grab> hits a player's hurtbox.
Returns true if the player was grabbed successfully.
It is run from the owner of the hurtbox that was hit.
Please note: Players that were recently grabbed ("grab_regrab_frame" > 0) CANNOT be grabbed!
*/
function hurtbox_grab_hit_player() {
	var _hitbox = argument[0];
	var _hurtbox = argument[1];

	//Check restrictions
	if (!calculate_hit_restriction(_hitbox, _hurtbox)) then return false;

	//Check if the player's regrab frame has reached zero!
	if (grab_regrab_frame > 0) then return false;

	//Grabbing players behind you
	if (!grab_opponents_behind)
		{
		if (sign(_hitbox.player_id.x - x) == _hitbox.facing && _hitbox.player_id.x != x)
			{
			if (abs(_hitbox.player_id.x - x) > grab_opponents_behind_threshold)
				{
				return false;
				}
			}
		}

	//Check invulnerability
	switch(_hurtbox.inv_type)
		{
		default:
		case INV.shielding:
		case INV.powershielding:
		case INV.heavyarmor:
		case INV.superarmor:
		case INV.counter:
		case INV.parry_shield:
		case INV.normal:
			combo_register(_hitbox.owner, _hurtbox.owner);
			hitbox_register_hit(_hitbox, false, true);
			//Change state of target
			attack_stop_ext(PLAYER_STATE.is_grabbed, false);
			player_move_to_front();
			//Reset the target's invulnerability
			invulnerability_set(INV.normal, -1);
			//Turn to face the attacker
			facing = -_hitbox.owner.facing;
			//Pass ID
			grab_hold_id = _hitbox.owner;
			//Set grab hold position
			grab_hold_enable = true;
			grab_hold_x = _hitbox.grab_destination_x;
			grab_hold_y = _hitbox.grab_destination_y;
			//Effects
			hit_vfx_style_create(_hitbox.hit_vfx_style, point_direction(x, y, _hitbox.owner.x, _hitbox.owner.y), _hitbox, 0);
			hit_sfx_play(_hitbox.hit_sfx);
			//Change state of the grabbing player (this results in the grab hitbox being destroyed)
			with(_hitbox.owner)
				{
				//Set the grab id, so the other player can break out of grabs
				grabbed_id = other.id;
				if (state == PLAYER_STATE.attacking)
					{
					attack_stop(PLAYER_STATE.grabbing);
					//Set the grab timer
					state_frame = calculate_grab_time(other.damage);
					}
				//If the grabbing player was interrupted, they do not enter the grabbing state
				else
					{
					attack_stop_preserve_state();
					}
				}
			//Acknowledge the grab
			return true;
			break;
		case INV.invincible:
			//No knockback or damage or hitlag
			//Do not add the player to the hitbox group array
			//This is because the opponent should be hit even if their invincibility runs out mid-attack
			break;
		case INV.deactivate:
			//Register a hit, but do nothing else
			hitbox_register_hit(_hitbox, false, true);
			break;
		case INV.reflector:
			//No knockback or damage or hitlag
			//Does not register as a hit
			break;
		case INV.parry_press:
			hitbox_register_hit(_hitbox, true, true);
			if (parry_press_grabs)
				{
				//Activate the other player's parry
				parry_press_trigger(_hitbox, true, id);
				break;
				}
			else
				{
				//Change state of target
				attack_stop(PLAYER_STATE.is_grabbed);
				//Turn to face the attacker
				facing = -_hitbox.owner.facing;
				//Pass ID
				grab_hold_enable = true;
				grab_hold_id = _hitbox.owner;
				//Set grab hold position
				grab_hold_x = _hitbox.grab_destination_x;
				grab_hold_y = _hitbox.grab_destination_y;
				//Change state of player
				with(_hitbox.owner)
					{
					attack_stop(PLAYER_STATE.grabbing);
					grabbed_id = other.id;
					//Set the grab timer
					state_frame = calculate_grab_time(other.damage);
					}
				//Effects
				hit_vfx_style_create(_hitbox.hit_vfx_style, point_direction(x, y, _hitbox.owner.x, _hitbox.owner.y), _hitbox, 0);
				hit_sfx_play(_hitbox.hit_sfx);
				//Acknowledge the grab
				return true;
				}
			break;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */