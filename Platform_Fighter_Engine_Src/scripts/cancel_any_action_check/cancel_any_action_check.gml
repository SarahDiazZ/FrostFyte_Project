///@category Attacking
/*
Allows the player to cancel an attack with any normal action, and returns true if they do.
The order in which the actions are checked is as follows:
	When on the ground:
		- Jump
		- Smash Attack
		- Ground Attack
		- Special Attack
		- Grab
		- Drop Through
		- Crouch
		- Roll
		- Shield
		- Dash
		- Walk
	When in the air:
		- Ledge Grab
		- Airdodge
		- Wall Cling
		- Wall Jump
		- Double Jump
		- Smash Attack
		- Air Attack
		- Special Attack
		- Fastfall
*/
function cancel_any_action_check() {
	if (on_ground())
		{
		if (cancel_jump_check())
			{
			return true;
			}
		if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
			item_system_type == ITEM_SYSTEM_TYPE.simplified)
			{
			if (allow_item_throws())
				{
				return true;
				}
			}
		if (allow_smash_attacks())
			{
			return true;
			}
		if (allow_special_attacks())
			{
			return true;
			}
		if (allow_ground_attacks())
			{
			return true;
			}
		if (allow_grabs())
			{
			return true;
			}
		if (check_drop_through())
			{
			attack_stop_preserve_state();
			return true;
			}
		if (check_crouch())
			{
			attack_stop_preserve_state();
			return true;
			}
		if (check_rolling())
			{
			attack_stop_preserve_state();
			return true;
			}
		if (check_shield())
			{
			attack_stop_preserve_state();
			return true;
			}
		if (cancel_dash_check())
			{
			return true;
			}
		if (check_walk())
			{
			attack_stop_preserve_state();
			return true;
			}
		}
	else
		{
		if (check_ledge_grab())
			{
			attack_stop_preserve_state();
			return true;
			}
		if (cancel_airdodge_check())
			{
			return true;
			}
		if (check_wall_cling())
			{
			attack_stop_preserve_state();
			return true;
			}
		if (check_wall_jump())
			{
			attack_stop_preserve_state();
			return true;
			}
		if (cancel_jump_check())
			{
			return true;
			}
		if (allow_special_attacks())
			{
			return true;
			}
		if (allow_smash_attacks())
			{
			return true;
			}
		if (allow_aerial_attacks())
			{
			return true;
			}
		fastfall_attack_try();
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */