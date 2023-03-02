///@param {real} lx		The x position of the left stick
///@param {real} ly		The y position of the left stick
///@param {real} rx		The x position of the right stick
///@param {real} ry		The y position of the right stick
function cpu_script1() {
	var _lx = argument[0];
	var _ly = argument[1];
	var _rx = argument[2];
	var _ry = argument[3];
	
	if (cpu_type == CPU_TYPE.attack)
		{
		//Recover with tether
		if (is_launched() || state == PLAYER_STATE.tumble || state == PLAYER_STATE.aerial)
			{
			var _ledge = instance_nearest(x, y, obj_ledge);
			if (_ledge != noone)
				{
				//Make sure you are offstage and facing the ledge
				if (sign(_ledge.x - x) == _ledge.image_xscale && facing == _ledge.image_xscale)
					{
					//Make sure you are close enough to tether
					if (point_distance(x, y, _ledge.x, _ledge.y) < 200)
						{
						cpu_press(INPUT.grab);
						cpu_release(INPUT.jump);
						}
					}
				}
			}
		else if (state == PLAYER_STATE.ledge_tether)
			{
			if (irandom(100) < 10)
				{
				//Quick tether
				cpu_press(INPUT.grab);
				}
			}
	
		//Charge variable
		if (!variable_struct_exists(custom_attack_struct, "dspec1_charge"))
			{
			custom_attack_struct.dspec1_charge = 0;
			}
	
		//Charge Down B when possible
		if (custom_attack_struct.dspec1_charge < 180 && state == PLAYER_STATE.aerial)
			{
			var _nearest = find_nearest_player(x, y, infinity, player_team, false);
			if (_nearest != noone)
				{
				//Make sure you are far from other players and over the stage
				var _over_stage = collision_line(x, y, x, room_height, obj_collidable, false, true);
				if (_over_stage != noone && point_distance(x, y, _nearest.x, _nearest.y) > 200)
					{
					_ly = 1;
					cpu_press(INPUT.special);
					cpu_hold(INPUT.special);
					}
				}
			}
		else if (custom_attack_struct.dspec1_charge >= 180)
			{
			//Always use forward throw
			if (state == PLAYER_STATE.grabbing)
				{
				_lx = facing;
				_ly = 0;
				}
			else if (state == PLAYER_STATE.attacking)
				{
				var _nearest = find_nearest_player(x, y, infinity, player_team, false);
				if (_nearest != noone)
					{
					if (point_distance(x, y, _nearest.x, _nearest.y) > 100)
						{
						if (is_launched(_nearest))
							{
							_ly = 1;
							cpu_press(INPUT.special);
							cpu_hold(INPUT.special);
							}
						}
					}
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