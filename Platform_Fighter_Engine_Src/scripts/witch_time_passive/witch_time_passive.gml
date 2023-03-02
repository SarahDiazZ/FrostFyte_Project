function witch_time_passive() {
	//Variables
	var _p = custom_passive_struct;
	if (!variable_struct_exists(_p, "witch_time_frame")) then _p.witch_time_frame = 0;
	if (!variable_struct_exists(_p, "witch_time_x")) then _p.witch_time_x = x;
	if (!variable_struct_exists(_p, "witch_time_y")) then _p.witch_time_y = y;
	
	//Slowdown
	if (_p.witch_time_frame % 8 != 0)
		{
		self_hitlag_frame = max(self_hitlag_frame, (_p.witch_time_frame % 8));
		}
	if ((_p.witch_time_frame - 1) % 8 == 0)
		{
		_p.witch_time_x = x;
		_p.witch_time_y = y;
		}
		
	//Ending
	_p.witch_time_frame -= 1;
	if (_p.witch_time_frame <= 0)
		{
		callback_remove(callback_passive, witch_time_passive);
		callback_remove(callback_draw_begin, witch_time_draw_begin);
		}
}
/* Copyright 2023 Springroll Games / Yosi */