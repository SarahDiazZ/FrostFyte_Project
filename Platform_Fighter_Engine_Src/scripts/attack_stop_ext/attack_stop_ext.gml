///@category Attacking
///@param {int} [state]					The state to change the player to
///@param {bool} [reset_hitboxes]		Whether to destroy the user's hitboxes or not
///@param {bool} [parry_stun]			Whether to allow the player to be parried or not
/*
Stops the player's current attack and resets all attack-related variables.
If no state is provided, the player enters either the grounded state or the aerial state.
All of the player's hitboxes and temporary hurtboxes are destroyed, unless the optional argument is false.
If the player has been parried (Parry Press), they enter the parry stun state, unless the optional argument is false.
*/
function attack_stop_ext() {
	var run = true;
	var _reset_hitboxes = argument_count > 1 ? argument[1] : true;
	var _parry_stun = argument_count > 2 ? argument[2] : true;

	//Reset attacking variables
	attack_phase = 0;
	attack_frame = 0;
	attack_script = -1;
	simple_attack_name = "";
	can_hitfall = false;

	/*Do not reset landing lag!*/

	//Reset hitboxes
	if (_reset_hitboxes)
		{
		hitbox_destroy_attached_all();
		hitbox_group_reset_all();
		any_hitbox_has_hit = false;
		any_hitbox_has_been_blocked = false;
		}

	//Reset hurtboxes
	with(obj_hurtbox)
		{
		if (hurtbox_type != HURTBOX_TYPE.permanent && owner == other.id)
			{
			instance_destroy();
			}
		}

	//Parry Stun
	if (_parry_stun)
		{
		if (run && check_parried()) then run = false;
		parry_stun_time = parry_press_stun_time_default;
		}

	//Set state (optional argument)
	if (run)
		{
		if (argument_count > 0)
			{
			state_set(argument[0]);
			run = false;
			}
		else
			{
			if (on_ground())
				{
				state_set(PLAYER_STATE.idle);
				}
			else
				{
				state_set(PLAYER_STATE.aerial);
				}
			run = false;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */