function poison_passive() {
	//Variables
	var _p = custom_passive_struct;
	if (!variable_struct_exists(_p, "poison_frame")) then _p.poison_frame = 0;
	
	//Timer
	_p.poison_frame -= 1;
	
	//Damage every 30 frames
	if (_p.poison_frame % 30 == 0)
		{
		apply_damage(id, 1);
		
		//VFX
		flash_color = $FF00AA;
		flash_alpha = 0.75;
		}
	
	//Ending
	if (_p.poison_frame <= 0)
		{
		callback_remove(callback_passive, poison_passive);
		}
}
/* Copyright 2023 Springroll Games / Yosi */