///@category Collisions
///@param {real} jump_speed			The character's jump speed
///@param {real} grav			The character's gravity
/*
Calculates how many pixels high a character with the specified jump speed and gravity would jump.
*/
function calculate_jump_height() {
	var _jump_speed = argument[0];
	var _grav = argument[1];
	var _vsp = -_jump_speed;
	var _vsp_frac = 0;
	var _y = 0;
	var _y_previous = 0;
	
	//Loop until the player would start falling
	for(var i = 0; i < 100; i++)
		{
		//Fractions (from <speed_fraction>)
		_vsp += _vsp_frac;
		_vsp_frac = (_vsp - (floor(abs(_vsp)) * sign(_vsp)));
		_vsp -= _vsp_frac;
		_vsp = floor(_vsp);
		
		//Increase the y
		_y += _vsp;
		
		//Return the jump height
		if (_vsp >= 0)
			{
			return max(-_y, -_y_previous);
			}
		
		//Update previous y
		_y_previous = _y;
		
		//Gravity
		_vsp += _grav;
		}
	
	return -1;
}
/* Copyright 2023 Springroll Games / Yosi */