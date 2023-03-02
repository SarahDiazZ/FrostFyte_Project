///@category Attacking
///@param {asset/string} attack			The attack script to start.
///@param {bool} [change_facing]		Whether the attack should run the <change_facing> script before starting
///@param {int} [stick]					The stick to change the facing with. Either <Lstick> or <Rstick>
///@param {int} [frame]					The frame to check to change the facing direction
/*
This function makes the calling player start the given attack script.
Players cannot start attacks that have cooldown, or have no uses left. The function will return false in these cases.
This resets all attack-related variables, and changes the player to the attacking state.
All hitboxes currently owned by the player are destroyed.
If the optional arguments for "change_facing" are given, then the <change_facing> script is run.
Finally, PHASE.start of the attack script is run.

If a string name of a simple attack is passed instead of a script index, the <simple_attack_runner> script will be started instead.
*/
function attack_start() {
	var _atk = argument[0];
	var _change_facing = argument_count > 1 ? argument[1] : false;
	var _stick = argument_count > 2 ? argument[2] : Lstick;
	var _frame = argument_count > 3 ? argument[3] : 0;

	assert(!is_undefined(_atk), "[attack_start] The attack script cannot be undefined!\n",
		"A common cause of this would be including parentheses after the attack script name during assignment, for example:\nmy_attacks[? \"Jab\"] = jab1();");
		
	//Simple Attacks
	if (is_string(_atk))
		{
		simple_attack_name = _atk;
		_atk = simple_attack_runner;
		}
	else
		{
		simple_attack_name = "";
		}
		
	//Set the script
	if (script_exists(_atk))
		{
		//Check the cooldown
		var _cooldown = attack_cooldowns[$ string(_atk)];
		if (!is_undefined(_cooldown) && _cooldown > 0)
			{
			//End the attack
			return false;
			}
			
		//Check the uses
		var _uses = attack_uses[$ string(_atk)];
		if (!is_undefined(_uses) && _uses != -1)
			{
			if (_uses <= 0)
				{
				//End the attack
				return false;
				}
			else
				{
				attack_uses[$ string(_atk)] -= 1;
				}
			}
			
		//Set the script
		attack_script = _atk;
		
		//Change the facing direction (optional)
		if (_change_facing)
			{
			change_facing(_stick, _frame);
			}
		
		//Item attack
		if (override_item_attacks()) then return true;
	
		//Attack phase
		attack_phase = 0;
		attack_frame = 0;

		//Flags & variables
		can_hitfall = false;
		landing_lag = attack_landing_lag_default;
		parry_stun_time = parry_press_stun_time_default;
		landed_on_ground = false;
		charge = 0;

		//Set the state
		state_set(PLAYER_STATE.attacking);

		//Reset the hitboxes
		hitbox_destroy_attached_all();
		hitbox_group_reset_all();
		any_hitbox_has_hit = false;
		any_hitbox_has_been_blocked = false;

		//Move to front
		player_move_to_front();
		
		//Reset the animation
		anim_reset();

		//Execute the first frame (the special start phase)
		script_execute(attack_script, PHASE.start);
		return true;
		}
	else
		{
		log("Tried to start an attack script that doesn't exist! (", _atk, ")");
		return false;
		}
}
/* Copyright 2023 Springroll Games / Yosi */