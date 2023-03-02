function ex_move_is_activated() {
	//Only runs if EX meters are enabled
	if (setting().match_ex_meter)
		{
		return custom_passive_struct.ex_move;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */