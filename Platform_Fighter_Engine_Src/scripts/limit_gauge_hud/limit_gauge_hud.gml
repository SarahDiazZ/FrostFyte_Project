///The HUD script for adding a limit gauge
function limit_gauge_hud() {
	var _args = argument[0];
	var _x = _args[@ 0];
	var _y = _args[@ 1];
	var _player = _args[@ 2];
	var _alpha = _args[@ 3];
	
	//Only works on the legacy HUD right now
	if (player_hud_type != HUD_TYPE.legacy) then exit;
	
	//Make sure the variable is initialized
	if (!variable_struct_exists(_player.custom_passive_struct, "limit_gauge"))
		{
		_player.custom_passive_struct.limit_gauge = 0;
		}
	
	var _limit_gauge = _player.custom_passive_struct.limit_gauge;
	var _limit_gauge_max = 500;
	draw_set_alpha(_alpha);
	draw_set_color(c_dkgray);
	draw_rectangle(_x - 60, _y - 60, _x + 30, _y - 52, false);
	if (_limit_gauge > 0)
		{
		draw_set_color(_limit_gauge == _limit_gauge_max ? $FFFF00 : $8934eb);
		draw_rectangle(_x - 58, _y - 58, _x - 58 + (86 * (_limit_gauge / _limit_gauge_max)), _y - 54, false);
		}
	draw_set_alpha(1);
	return;
}
/* Copyright 2023 Springroll Games / Yosi */