///The HUD script for adding a tension gauge
function tension_gauge_hud() {
	var _args = argument[0];
	var _x = _args[@ 0];
	var _y = _args[@ 1];
	var _player = _args[@ 2];
	var _alpha = _args[@ 3];

	//Only works on the legacy HUD right now
	if (player_hud_type != HUD_TYPE.legacy) then exit;
	
	//Make sure the variable is initialized
	if (!variable_struct_exists(_player.custom_passive_struct, "tension_gauge"))
		{
		_player.custom_passive_struct.tension_gauge = 0;
		}
	
	var _tension_gauge = _player.custom_passive_struct.tension_gauge;
	var _tension_gauge_max = 500;
	draw_set_alpha(_alpha);
	draw_set_color(c_dkgray);
	draw_rectangle(_x - 60, _y - 60, _x + 30, _y - 52, false);
	if (_tension_gauge > 0)
		{
		if (_tension_gauge < _tension_gauge_max div 2)
			draw_set_color($d0f099);
		else if (_tension_gauge < _tension_gauge_max)
			draw_set_color($34eb89);
		else
			draw_set_color($05deff);
			
		draw_rectangle(_x - 58, _y - 58, _x - 58 + (86 * (_tension_gauge / _tension_gauge_max)), _y - 54, false);
		}
	draw_set_alpha(1);
	return;
}
/* Copyright 2023 Springroll Games / Yosi */