///@category Collisions
///@param {real} [friction]				The horizontal friction
///@param {real} [gravity]				The gravity
///@param {real} [max_fall_speed]		The maximum fall speed
/*
Applies friction and/or gravity to the player object.
If no arguments are given, the character's set "ground_friction" is applied.
If a friction argument and a gravity argument are given, friction and gravity are applied and the maximum fall speed is the character's set "max_fall_speed".
*/
function friction_gravity() {
	var _fric = argument_count > 0 ? argument[0] : ground_friction;
	//Apply friction
	hsp = approach(hsp, 0, _fric);
	//Apply gravity
	if (argument_count > 1)
		{
		var _grav = argument[1];
		var _max =  argument_count > 2 ? argument[2] : max_fall_speed;
		//If you are rising upwards
		if (vsp <= 0)
			{
			//If there's no blocks or you're in a platform
			if (!on_ground())
				{
				//Apply gravity
				if (vsp < _max)
					{
					vsp = min(_max, vsp + _grav);
					if (vsp == _max) then vsp_frac = 0;
					}
				}
			}
		else
		//If you are falling
		if (vsp > 0)
			{
			//If you are not pressing down on the control stick
			if (!stick_tilted(Lstick, DIR.down))
				{
				//If you are not on a platform
				if (!on_ground())
					{
					//Apply gravity
					if (vsp < _max)
						{
						vsp = min(_max, vsp + _grav);
						if (vsp == _max) then vsp_frac = 0;
						}
					}
				}
			else
			//If you are pressing down on the control stick
				{
				//If there are not solids under you
				if (!on_solid(x, y))
					{
					//Apply gravity
					if (vsp < _max)
						{
						vsp = min(_max, vsp + _grav);
						if (vsp == _max) then vsp_frac = 0;
						}
					}
				else
					{
					vsp = 0;
					vsp_frac = 0;
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */