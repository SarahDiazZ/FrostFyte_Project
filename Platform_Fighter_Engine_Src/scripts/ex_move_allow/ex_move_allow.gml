///@param {int} splits			How many sections of the meter the activation costs 
///@param {real} [meter_amount]		How much meter the activation costs (overrides the first argument)
function ex_move_allow() {
	//Only runs if EX meters are enabled
	if (setting().match_ex_meter)
		{
		var _p = custom_passive_struct;
		
		//You can only EX a move in the first few frames
		if (state_time <= 5 && !_p.ex_move)
			{
			//EX input
			if (input_held(INPUT.attack))
				{
				var _amount = 0;
				if (argument_count == 1)
					{
					_amount = floor((_p.ex_max / _p.ex_split) * argument[0]);
					}
				else
					{
					_amount = argument[1];
					}
			
				if (_p.ex_meter >= _amount)
					{
					_p.ex_move = true;
					_p.ex_meter = _p.ex_meter - _amount;
					
					//VFX
					vfx_create(spr_shine_large, 1, 0, 14, x, y, 1, prng_number(0, 360));
					
					//Sound effect
					game_sound_play(snd_activation);
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */