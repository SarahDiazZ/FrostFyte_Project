function ex_move_reset() {
	//Only runs if EX meters are enabled
	if (setting().match_ex_meter)
		{
		var _p = custom_passive_struct;
		_p.ex_move = false;
		}
}
/* Copyright 2023 Springroll Games / Yosi */