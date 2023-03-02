///The passive script for adding a limit gauge
///Warning: <character_static_attacks> must be turned off!
function limit_gauge_passive() {
	//assert(!character_static_attacks, "[limit_gauge_passive] The macro character_static_attacks must be false");
	
	var _limit_gauge_max = 500;

	//Make sure the variable is initialized
	if (!variable_struct_exists(custom_passive_struct, "limit_gauge"))
		{
		custom_passive_struct.limit_gauge = 0;
		}

	//Handles the limit gauge
	if (state == PLAYER_STATE.hitlag && state_frame == 1)	
		{
		custom_passive_struct.limit_gauge = min(_limit_gauge_max, custom_passive_struct.limit_gauge + stored_hitstun);
		}
	if (state == PLAYER_STATE.attacking && attack_connected())
		{
		custom_passive_struct.limit_gauge = min(_limit_gauge_max, custom_passive_struct.limit_gauge + 1);
		}
	if (custom_passive_struct.limit_gauge == _limit_gauge_max)
		{
		my_attacks[$ "Fspec"] = fspec_cross_slash;
		if (state == PLAYER_STATE.attacking && attack_script == fspec_cross_slash)
			{
			custom_passive_struct.limit_gauge = 0;
			my_attacks[$ "Fspec"] = fspec_afterburner_kick;
			}
		}
	else
		{
		my_attacks[$ "Fspec"] = fspec_afterburner_kick;
		}
	if (is_knocked_out())
		{
		custom_passive_struct.limit_gauge = 0;
		}
	return;
}
/* Copyright 2023 Springroll Games / Yosi */