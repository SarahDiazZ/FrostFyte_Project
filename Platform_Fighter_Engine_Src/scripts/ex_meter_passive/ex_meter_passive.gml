function ex_meter_passive() {
	assert(setting().match_ex_meter, "[ex_meter_passive] This script cannot be used if the EX meter match setting is not enabled");
	
	//Variables
	var _p = custom_passive_struct;
	if (!variable_struct_exists(_p, "ex_meter")) then _p.ex_meter = 0;
	if (!variable_struct_exists(_p, "ex_max")) then _p.ex_max = ex_meter_max;
	if (!variable_struct_exists(_p, "ex_split")) then _p.ex_split = ex_meter_split;
	if (!variable_struct_exists(_p, "ex_move")) then _p.ex_move = false;
	
	//Passive increase
	if (obj_game.state == GAME_STATE.normal && !is_knocked_out())
		{
		_p.ex_meter = clamp(_p.ex_meter + 0.2, 0, _p.ex_max);
		}
		
	//Lose some meter when knocked out
	if (state == PLAYER_STATE.respawning && state_time == 0)
		{
		_p.ex_meter = clamp(_p.ex_meter - (_p.ex_max div _p.ex_split), 0, _p.ex_max);
		}
}
/* Copyright 2023 Springroll Games / Yosi */