///@category Collisions
///@param {int} hsp						The horizontal amount to move
///@param {int} vsp						The vertical amount to move
///@param {bool} destroy_on_blocks		Whether the entity should destroy itself if it hits a block
///@param {bool} bounce					Whether the entity should bounce off blocks or not
///@param {real} bounce_multiplier		The amount the speed is multiplied by when bouncing
///@param {bool} drop_through			Whether the entity should fall through platforms or not
/*
This function can be used to move entity objects and handle collisions.
It returns a struct with the following properties:
	- hsp : The final hsp after moving
	- vsp : The final vsp after moving
	- destroy : Whether the entity should be destroyed or not
	
Warning: This function does NOT account for slopes!
*/
function entity_move_simple() {
	var _hsp = argument[0];
	var _vsp = argument[1];
	var _destroy = argument[2];
	var _bounce = argument[3];
	var _multiplier = argument[4];
	var _drop = argument[5];
	
	//Return struct
	var _results =
		{
		hsp : _hsp,
		vsp : _vsp,
		destroy : false,
		};

	repeat(abs(_hsp))
		{
		if (!collision(x + sign(_hsp), y, [FLAG.solid]))
			{
			x += sign(_hsp);
			}
		else
			{
			//Bounce
			if (_bounce)	
				{
				_results.hsp = -_hsp * _multiplier;
				break;
				}
			else
				{
				if (_destroy)
					{
					_results.destroy = true;
					}
				_results.hsp = 0;
				break;
				}
			}
		}
		
	repeat(abs(_vsp))
		{
		if (_vsp < 0)
			{
			if (!collision(x, y + sign(_vsp), [FLAG.solid]))
				{
				y += sign(_vsp);
				}
			else
				{
				//Bounce
				if (_bounce)	
					{
					_results.vsp = -_vsp * _multiplier;
					break;
					}
				else
					{
					if (_destroy)
						{
						_results.destroy = true;
						}
					_results.vsp = 0;
					break;
					}
				}
			}
		else if (_vsp > 0)
			{
			if (!_drop)
				{
				if (on_ground())
					{
					//Bounce
					if (_bounce)	
						{
						_results.vsp = -_vsp * _multiplier;
						break;
						}
					else
						{
						if (_destroy)
							{
							_results.destroy = true;
							}
						_results.vsp = 0;
						break;
						}
					}
				else
					{
					y += sign(_vsp);
					}
				}
			else
				{
				if (!on_solid())
					{
					y += sign(_vsp);
					}
				else
					{
					//Bounce
					if (_bounce)	
						{
						_results.vsp = -_vsp * _multiplier;
						break;
						}
					else
						{
						if (_destroy)
							{
							_results.destroy = true;
							}
						_results.vsp = 0;
						break;
						}
					}
				}
			}
		}
		
	return _results;
}
/* Copyright 2023 Springroll Games / Yosi */