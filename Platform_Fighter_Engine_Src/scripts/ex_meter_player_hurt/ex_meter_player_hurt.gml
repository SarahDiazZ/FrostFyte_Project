function ex_meter_player_hurt(){
	var _args = argument[0];
	var _hitbox = _args[@ 0];
	var _hurtbox = _args[@ 1];
	
	//Increase
	var _p = custom_passive_struct;
	_p.ex_meter = clamp(_p.ex_meter + (_hitbox.damage * 0.5), 0, _p.ex_max);
}
/* Copyright 2023 Springroll Games / Yosi */