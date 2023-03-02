///@param {real} lx		The x position of the left stick
///@param {real} ly		The y position of the left stick
///@param {real} rx		The x position of the right stick
///@param {real} ry		The y position of the right stick
function cpu_script4() {
	var _lx = argument[0];
	var _ly = argument[1];
	var _rx = argument[2];
	var _ry = argument[3];
	
	if (cpu_type == CPU_TYPE.attack)
		{
		//Use Down B when far from the center of the room
		var _cpu_main_stage_distance = obj_stage_manager.cpu_main_stage_distance;
		if (!on_ground())
			{
			if (abs(x - (room_width / 2)) > _cpu_main_stage_distance)
				{
				if (attack_cooldowns[$ string(dspec4)] == 0)
					{
					_lx = 0;
					_ly = 1;
					cpu_press(INPUT.special);
					}
				}
			}
		
		//Use Uppercut if the log teleport wouldn't be smart
		if (state == PLAYER_STATE.attacking && attack_script == uspec4)
			{
			var _log = noone;
			with(obj_uspec4_log)
				{
				if (owner == other.id)
					{
					_log = id;
					break;
					}
				}
			if (_log != noone && _log.y > (y - 32))
				{
				cpu_press(INPUT.special);
				cpu_release(INPUT.attack);
				}
			}
	
		//Uppercut after a wall jump
		if (state == PLAYER_STATE.wall_jump)
			{
			cpu_press(INPUT.special);
			cpu_release(INPUT.attack);
			_ly = -1;
			_lx = 0;
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