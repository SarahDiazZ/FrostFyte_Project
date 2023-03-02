function replays_ui_metadata_label_draw() {
	/*
	Please note: This script uses the struct accessor to prevent weird crashes on the Opera GX export.
	*/
	try
		{
		var _m = obj_replays_ui.replay_metadata;
		if (is_undefined(_m) || !is_struct(_m)) then return;
	
		var _y = bbox_top;
		var _center = x + (sprite_width div 2);
		var _left = _center - 64;
		var _right = _center + 64;
	
		//Title
		draw_set_font(fnt_window);
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_text(_center, _y, "REPLAY INFO");
	
		//Replay Length
		_y += 32;
		draw_set_font(fnt_consolas);
		draw_set_halign(fa_left);
		draw_text(_left, _y, "Length");
		draw_set_halign(fa_right);
		var _game_frames = _m[$ "replay_total_frames"] - (countdown_start_time * 3);
		var _total_seconds = _game_frames / 60;
		var _minutes = _total_seconds div 60;
		var _seconds = floor(_total_seconds mod 60);
		draw_text(_right, _y, string(_minutes) + ":" + string_replace(string_format(_seconds, 2, 0), " ", "0"));
	
		//Match Settings
		_y += 24;
		draw_sprite(spr_icon_stock, 0, _left + 8, _y + 8);
		draw_text(_right, _y, _m[$ "match_stock"] != 0 ? _m[$ "match_stock"] : "---");
		_y += 16;
		draw_sprite(spr_icon_time, 0, _left + 8, _y + 8);
		draw_text(_right, _y, _m[$ "match_time"] != 0 ? _m[$ "match_time"] : "---");
		_y += 16;
		draw_sprite(spr_icon_stamina, 0, _left + 8, _y + 8);
		draw_text(_right, _y, _m[$ "match_stamina"] != 0 ? _m[$ "match_stamina"] : "---");
		_y += 16;
		draw_sprite(spr_icon_items, 0, _left + 8, _y + 8);
		draw_text(_right, _y, _m[$ "match_items_enable"] ? string(_m[$ "match_items_frequency"]) + "%" : "OFF");
		_y += 16;
		var _x = _left + 8;
		if (_m[$ "match_screen_wrap"])
			{
			draw_sprite(spr_icon_screen_wrap, 0, _x, _y + 8);
			_x += 24;
			}
		if (_m[$ "match_ex_meter"])
			{
			draw_sprite(spr_icon_ex_meter, 0, _x, _y + 8);
			_x += 24;
			}
		if (_m[$ "match_fs_meter"])
			{
			draw_sprite(spr_icon_fs_meter, 0, _x, _y + 8);
			_x += 24;
			}
	
		//Players
		_y += 16;
		_left -= 32;
		_right += 32;
		draw_set_halign(fa_left);
		var _player_data = _m[$ "player_data"];
		for(var i = 0; i < array_length(_player_data); i++)
			{
			var _p = _player_data[@ i];
			_y += 16;
			
			//Team colors
			if (_m[$ "match_team_mode"])
				{
				draw_set_color(player_color_get(_p[$ "team"]));
				}
			draw_text(_left, _y, _p[$ "name"] + " (" + character_data_get(_p[$ "character"], CHARACTER_DATA.name) + ")");
		
		
			//Character stock icon
			var _palette_column_arrays = character_data_get(_p[$ "character"], CHARACTER_DATA.palette_column_arrays);
			palette_shader_simple_set(_palette_column_arrays[@ 0], _palette_column_arrays[@ _p[$ "color"]]);
			draw_sprite_ext(character_data_get(_p[$ "character"], CHARACTER_DATA.stock_sprite), 0, _right - 8, _y + 8, 1, 1, 0, c_white, 1);
			shader_reset();
			}
	
		//Stage
		_y += 112 - 8;
		var _data = stage_data_get(_m[$ "match_stage"]);
		draw_sprite_ext(_data[$ "sprite"], _data[$ "frame"], _center, _y, 1, 1, 0, c_white, 1);
		}
	catch (_e)
		{
		log(_e);
		}
}
/* Copyright 2023 Springroll Games / Yosi */