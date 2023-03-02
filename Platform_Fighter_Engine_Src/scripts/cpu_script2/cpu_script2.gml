///@param {real} lx		The x position of the left stick
///@param {real} ly		The y position of the left stick
///@param {real} rx		The x position of the right stick
///@param {real} ry		The y position of the right stick
function cpu_script2() {
	var _lx = argument[0];
	var _ly = argument[1];
	var _rx = argument[2];
	var _ry = argument[3];
	
	if (cpu_type == CPU_TYPE.attack)
		{
		var _center = sign((room_width / 2) - x);
	
		//Make sure to not SD with Up B
		if (state == PLAYER_STATE.attacking && attack_script == uspec_fox)
			{
			//Point toward the nearest ledge
			var _ledge = instance_nearest(x, y, obj_ledge);
			if (_ledge != noone)
				{
				//Cancel Up B into the ground if the ledge is below you
				if (_ledge.y > bbox_top && sign(x - _ledge.x) == _ledge.image_xscale)
					{
					_lx = 0;
					_ly = 1;
					}
				else
					{
					var _dir = point_direction(x, y, _ledge.x, _ledge.y);
					_lx = lengthdir_x(1, _dir);
					_ly = lengthdir_y(1, _dir);
					}
				}
			}
		//Make sure to not SD with Side B
		else if ((cpu_check_input(INPUT.special) || input_pressed(INPUT.special, buffer_time_standard, false)) && _lx != 0)
			{
			if (!on_ground())
				{
				_lx = _center;
				}
			}
		
		//Try to stick C4 on players
		var _c4 = noone;
		with(obj_dspec_c4_bomb)
			{
			if (owner == other.id)
				{
				_c4 = id;
				break;
				}
			}
		if (_c4 == noone)
			{
			var _nearest = find_nearest_player(x, y, infinity, player_team, false);
			if (_nearest != noone)
				{
				//If the opponent is directly under you
				if (abs(x - _nearest.x) < 25 && (y - _nearest.y) < 10)
					{
					//Drop C4
					if (random(100) < 25)
						{
						_lx = 0;
						_ly = 1;
						cpu_press(INPUT.special);
						}
					}
				}
			}
		//Try to blow up C4 on players
		else
			{
			if (irandom(100) < 15 && point_distance(x, y, _c4.x, _c4.y) > 150 && on_ground())
				{
				_lx = 0;
				_ly = 1;
				cpu_press(INPUT.special);
				}
			}
		}
	
	//Return the changed stick coordinates
	return
		{
		lx : _lx,
		ly : _ly,
		rx : _rx,
		ry : _ry,
		};
}
/* Copyright 2023 Springroll Games / Yosi */