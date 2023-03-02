///@category Attacking
///@param {real} initial_direction		The initial angle of the knockback
///@param {real} stick_direction		The angle of the control stick
///@param {real} max_di					The maximum amount the initial angle can be influenced
/*
Calculates a new angle based on the initial knockback angle and the direction of the control stick.
*/
function calculate_di_direction() {
	var _dir, _max_di, di, _stick_direction, _temp;
	_dir = argument[0];
	_stick_direction = argument[1];
	_max_di = argument[2];

	//If stick is past a threshold
	if (stick_tilted(Lstick))
		{
		//Set a temporary placeholder variable, which holds the stick direction angle if the dir is always zero
		_temp = (_stick_direction - _dir);
	
		//If the angle is more than 90 degrees in any direction, it goes back toward zero
		if (abs(angle_difference(_temp, 0)) > 90)
			{
			_temp = (180 - _temp);
			}
		
		//The DI angle is the direction + the percent distance * the maximum DI.
		di = _dir + (angle_difference(_temp, 0) / 90) * _max_di;
	
		//Snap DI if it's close enough
		if (di_correction_max > 0)
			{
			if (abs(angle_difference(_dir + 90, _stick_direction)) <= di_correction_max)
				{
				di = _dir + _max_di;
				}
			else if (abs(angle_difference(_dir - 90, _stick_direction)) <= di_correction_max)
				{
				di = _dir - _max_di;
				}
			}
		}
	else
		{
		//No input means no DI
		di = _dir;
		}
	return di;
}
/* Copyright 2023 Springroll Games / Yosi */