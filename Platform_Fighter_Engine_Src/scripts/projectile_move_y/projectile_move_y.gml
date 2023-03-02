///@category Collisions
///@param {bool} [bounce]					Whether the entity should bounce off blocks or not
///@param {real} [bounce_multiplier]		The amount the speed is multiplied by when bouncing
///@param {bool} [drop_through]				
/*
Moves a projectile vertically, with bouncing.
If the projectile has destroy_on_blocks set to true, it will be destroyed if it collides with a block.
If drop_through is true, the projectile can move downward through platforms.
*/
function projectile_move_y() {
	var _b = argument_count > 0 ? argument[0] : false;
	var _m = argument_count > 1 ? argument[1] : 1;
	var _drop = argument_count > 2 ? argument[2] : false;

	repeat(abs(vsp))
		{
		if (vsp < 0)
			{
			if (!collision(x, y + sign(vsp), [FLAG.solid]))
				{
				y += sign(vsp);
				}
			else
				{
				//Bounce
				if (_b)	
					{
					vsp = -vsp * _m;
					break;
					}
				else
					{
					if (destroy_on_blocks)
						{
						destroy = true;
						}
					vsp = 0;
					break;
					}
				}
			}
		else if (vsp > 0)
			{
			if (!_drop)
				{
				if (on_ground())
					{
					//Bounce
					if (_b)	
						{
						vsp = -vsp * _m;
						break;
						}
					else
						{
						if (destroy_on_blocks)
							{
							destroy = true;
							}
						vsp = 0;
						break;
						}
					}
				else
					{
					y += sign(vsp);
					}
				}
			else
				{
				if (!on_solid())
					{
					y += sign(vsp);
					}
				else
					{
					//Bounce
					if (_b)	
						{
						vsp = -vsp * _m;
						break;
						}
					else
						{
						if (destroy_on_blocks)
							{
							destroy = true;
							}
						vsp = 0;
						break;
						}
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */