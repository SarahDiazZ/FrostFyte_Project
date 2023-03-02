///@param {real} lx		The x position of the left stick
///@param {real} ly		The y position of the left stick
///@param {real} rx		The x position of the right stick
///@param {real} ry		The y position of the right stick
function cpu_script0() {
	var _lx = argument[0];
	var _ly = argument[1];
	var _rx = argument[2];
	var _ry = argument[3];
	
	if (cpu_type == CPU_TYPE.attack)
		{
		var _center = sign((room_width / 2) - x);
		
		//Recover with afterburner kick
		if (is_launched() || state == PLAYER_STATE.tumble)
			{
			var _ledge = instance_nearest(x, y, obj_ledge);
			if (_ledge != noone)
				{
				//Make sure you are offstage
				if (sign(_ledge.x - x) == _ledge.image_xscale)
					{
					//Make sure you can still use afterburner kick
					if (attack_can_start(fspec_afterburner_kick))
						{
						cpu_press(INPUT.special);
						cpu_release(INPUT.attack);
						cpu_release(INPUT.jump);
						cpu_release(INPUT.shield);
						_lx = _center;
						_ly = 0;
						}
					}
				}
			}
		else if (state == PLAYER_STATE.attacking && attack_script == fspec_afterburner_kick)
			{
			//Angle downwards
			var _ledge = instance_nearest(x, y, obj_ledge);
			if (_ledge != noone)
				{
				//Make sure you are offstage and not too far below the ledge
				if (sign(_ledge.x - x) == _ledge.image_xscale && _ledge.y > y + 50)
					{
					_lx = 0;
					_ly = 1;
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