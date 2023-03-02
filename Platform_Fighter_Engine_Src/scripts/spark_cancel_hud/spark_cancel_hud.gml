///The HUD script for adding spark cancels
function spark_cancel_hud() {
	var _args = argument[0];
	var _x = _args[@ 0];
	var _y = _args[@ 1];
	var _player = _args[@ 2];
	var _alpha = _args[@ 3];
	
	//Only works on the legacy HUD right now
	if (player_hud_type != HUD_TYPE.legacy) then exit;
	
	//Make sure the variable is initialized
	if (!variable_struct_exists(_player.custom_passive_struct, "sparks"))
		{
		_player.custom_passive_struct.sparks = 0;
		}
	
	var _sparks = _player.custom_passive_struct.sparks;
	
	if (_sparks > 0)
		{
		draw_sprite_ext(spr_spark_cancel_hud, 0, _x, _y, 2, 2, 0, c_white, _alpha);
		}
	return;
}
/* Copyright 2023 Springroll Games / Yosi */