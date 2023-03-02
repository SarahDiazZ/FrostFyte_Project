///@description
//Winner
var _winner = engine().win_screen_order[@ win_screen_last_index];
var _character = _winner[@ WIN_SCREEN_DATA.character];
var _color = _winner[@ WIN_SCREEN_DATA.color];
var _palette_base = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ 0];
var _palette_swap = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ _color];
var _render = character_data_get(_character, CHARACTER_DATA.render);
var _value = (state == "winner" ? state_timer : 0);

//Alpha
draw_set_alpha((100 - _value) / 100);

//Player render
var _scale = win_screen_winner_render_scale;
if (!setting().disable_shaders)
	{
	palette_shader_simple_set(_palette_base, _palette_swap);
	draw_sprite_ext(_render, 0, -_value + (screen_width / 1.5), (screen_height / 2) - 20, _scale, _scale, 0, c_white, 1);
	shader_reset();
	}
else
	{
	var _blend = palette_color_get(character_data_get(_character, CHARACTER_DATA.palette_data), 0, _color);
	draw_sprite_ext(_render, 0, -_value + (screen_width / 1.5), (screen_height / 2) - 20, _scale, _scale, 0, _blend, 1);
	}

//Text Transformations
if (!setting().disable_shaders) then shader_set(shd_win_screen_text);

//Character name
draw_set_font(fnt_win);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(50 + _value, (screen_height / 3) - 60, win_name);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(55 + _value, (screen_height / 3) - 64, win_name);

//Player name
if (state != "winner")
	{
	var _player_name = _winner[@ WIN_SCREEN_DATA.player_name];
	draw_set_alpha((100 - state_timer) / 100);
	draw_set_font(fnt_win_subtitle);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(120 + state_timer, (screen_height / 3) + 60, _player_name);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(123 + state_timer, (screen_height / 3) + 58, _player_name);
	}

shader_reset();

//Reset
draw_set_alpha(1);

//Losers
if (state == "losers")
	{
	draw_set_alpha((100 - state_timer) / 100);
	draw_set_font(fnt_podium);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	var _spacing = screen_width / (win_screen_last_index + 1); //Screen width divided by the number of players in the match
	var _vspace = (32 / max_players);
	//Special layout in 2 player games
	if (win_screen_last_index == 1)
		{
		_spacing = (screen_width / 3) - 70;
		}
		
	for(var i = 0; i < win_screen_last_index; i++)
		{
		var _place = (win_screen_last_index - i - 1);
		var _x = (_spacing * _place) + _spacing;
		var _y = lerp(screen_height - 96, screen_height, state_timer / 100) + (_vspace * _place);
		var _loser = engine().win_screen_order[@ i];
		var _character = _loser[@ WIN_SCREEN_DATA.character];
		var _color = _loser[@ WIN_SCREEN_DATA.color];
		var _palette_base = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ 0];
		var _palette_swap = character_data_get(_character, CHARACTER_DATA.palette_column_arrays)[@ _color];
		var _portrait = character_data_get(_character, CHARACTER_DATA.portrait);
		var _name = _loser[@ WIN_SCREEN_DATA.player_name];

		//Podiums
		if (setting().match_team_mode)
			{
			var _team = _loser[@ WIN_SCREEN_DATA.team];
			draw_sprite_ext(spr_win_screen_podium, 8, _x, _y, 2, 2, 0, player_color_get(_team), 1);
			}
		else
			{
			draw_sprite_ext(spr_win_screen_podium, _place, _x, _y, 2, 2, 0, c_white, 1);
			}
	
		//Player portrait outline
		var _scale = win_screen_losers_portrait_scale;
		draw_sprite_ext(_portrait, 0, _x + 2, _y, _scale, _scale, 0, c_black, 1);
		draw_sprite_ext(_portrait, 0, _x - 2, _y, _scale, _scale, 0, c_black, 1);
		draw_sprite_ext(_portrait, 0, _x, _y + 2, _scale, _scale, 0, c_black, 1);
		draw_sprite_ext(_portrait, 0, _x, _y - 2, _scale, _scale, 0, c_black, 1);
		
		if (!setting().disable_shaders)
			{
			palette_shader_simple_set(_palette_base, _palette_swap);
			draw_sprite_ext(_portrait, 0, _x, _y, _scale, _scale, 0, c_white, 1);
			shader_reset();
			}
		else
			{
			var _blend = palette_color_get(character_data_get(_character, CHARACTER_DATA.palette_data), 0, _color);
			draw_sprite_ext(_portrait, 0, _x, _y, _scale, _scale, 0, _blend, 1);
			}
			
		//Name
		draw_text_outline(_x, _y + 52, _name, c_black, c_white);
		}
		
	draw_set_alpha(1);
	}

//Prompt Text
if (setting().replay_record && !setting().replay_mode)
	{
	if (state != "winner" || !can_save_replay)
		{
		var _c = c_black;
		var _text = can_save_replay ? "Press X / Shift to save a replay" : "Replay Saved!";
		draw_set_font(fnt_consolas);
		draw_set_color(c_white);
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
		draw_set_alpha(0.5);
		draw_rectangle_color(screen_width - (string_width(_text) + 12), 4, screen_width - 4, 28, _c, _c, _c, _c, false);
		draw_set_alpha(1);
		draw_text(screen_width - 8, 8, _text);
		}
	}
/* Copyright 2023 Springroll Games / Yosi */