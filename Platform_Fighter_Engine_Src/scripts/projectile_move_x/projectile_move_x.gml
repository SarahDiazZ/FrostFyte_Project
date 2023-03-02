///@category Collisions
///@param {bool} [bounce]					Whether the entity should bounce off blocks or not
///@param {real} [bounce_multiplier]		The amount the speed is multiplied by when bouncing
/*
Moves a projectile horizontally, with bouncing.
If the projectile has destroy_on_blocks set to true, it will be destroyed if it collides with a block.
*/
function projectile_move_x() {
	var _b = argument_count > 0 ? argument[0] : false;
	var _m = argument_count > 1 ? argument[1] : 1;

	repeat(abs(hsp))
		{
		if (!collision(x + sign(hsp), y, [FLAG.solid]))
			{
			x += sign(hsp);
			}
		else
			{
			//Bounce
			if (_b)	
				{
				hsp = -hsp * _m;
				break;
				}
			else
				{
				if (destroy_on_blocks)
					{
					destroy = true;
					}
				hsp = 0;
				break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */