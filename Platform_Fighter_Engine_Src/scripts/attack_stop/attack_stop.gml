///@category Attacking
///@param {int} [state]		The state to change the player to, from the PLAYER_STATE enum.
/*
Stops the player's current attack and resets all attack-related variables.
If no state is provided, the player enters either the grounded state or the aerial state.
All of the player's hitboxes and temporary hurtboxes are destroyed.
If the player has been parried (Parry Press), they enter the parry stun state.
*/
function attack_stop() {
	var run = true;

	//Reset attacking variables
	attack_phase = 0;
	attack_frame = 0;
	attack_script = -1;
	simple_attack_name = "";
	can_hitfall = false;
	charge = 0;

	/*Do not reset landing lag!*/

	//Reset hitboxes
	hitbox_destroy_attached_all();
	hitbox_group_reset_all();
	any_hitbox_has_hit = false;
	any_hitbox_has_been_blocked = false;
	
	//Reset hurtboxes
	with(obj_hurtbox)
		{
		if (hurtbox_type != HURTBOX_TYPE.permanent && owner == other.id)
			{
			instance_destroy();
			}
		}

	//Parry Stun
	if (run && check_parried()) then run = false;
	
	//Reset the parry stun time
	parry_stun_time = parry_press_stun_time_default;
	
	//End respawn invulnerability
	if (respawn_inv_end_on_attack)
		{
		with(hurtbox)
			{
			if (!inv_override && inv_type == INV.invincible)
				{
				inv_type = INV.normal;
				inv_frame = 0;
				inv_override = true;
				}
			}
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