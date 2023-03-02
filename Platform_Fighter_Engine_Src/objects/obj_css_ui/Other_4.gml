///@description
state = CSS_STATE.normal;

group_start_number = 10; //Make sure the UI group doesn't overlap with anything else!

css_back_button_timer = 0; //Timer for holding the back button to open the main menu sidebar

//Match settings
match_settings_y = -256;
match_settings_choices =
	[
	"Stock",
	"Time",
	"Stamina",
	"Teams",
	"Team Attack",
	"Items",
	"Screen Wrap",
	"EX Meter",
	"Final Smash Meter",
	];
match_settings_current = 0;
match_settings_selector = noone;
var _vals = stamina_valid_values;
stamina_index = 0;
for(var i = 0; i < array_length(_vals); i++)
	{
	if (_vals[@ i] == setting().match_stamina)
		{
		stamina_index = i;
		break;
		}
	}
var _vals = items_frequency_valid_values;
items_frequency_index = 0;
for(var i = 0; i < array_length(_vals); i++)
	{
	if (_vals[@ i] == setting().match_items_frequency)
		{
		items_frequency_index = i;
		break;
		}
	}

//Background animation
menu_background_color_set($32A9F8);

//Menu Input System
mis_init();
mis_auto_connect_enable(true);
mis_device_disconnect_all();
mis_device_connect_callback_set
	(
	function(_device_id) 
		{
		//Add a new player to the Character Select Screen
		var _cursor_index = engine().css_index_current;
		var _group = group_start_number + engine().css_index_current;
		var _player_id = css_player_add
			(
			mis_device_get(_device_id, MIS_DEVICE_PROPERTY.port_number), 
			mis_device_convert_to_game_device(mis_device_get(_device_id, MIS_DEVICE_PROPERTY.device_type)),
			undefined,
			false,
			css_ui_player_custom_struct_build
				(
				_device_id,
				_cursor_index,
				_group,
				noone,
				room_width div 2,
				room_height div 2,
				true,
				),
			);
			
		//Exit out if the player could not be added
		if (is_undefined(_player_id)) then return;
		
		//Autogenerate a new profile
		css_player_set
			(
			_player_id, 
			CSS_PLAYER.profile,
			profile_create
				(
				"PLAYER " + string(css_players_count()),
				custom_controls_create(),
				true,
				)
			);
			
		//Add the UI cursor
		ui_cursor_add(_cursor_index, room_width div 2, room_height div 2);
		
		//Make the player hold the token
		css_player_get(_player_id, CSS_PLAYER.custom).token_held = _player_id;
		
		//Create the necessary UI
		css_ui_refresh();
		}
	);

//Loading existing CSS data
if (engine().load_css_data)
	{
	engine().load_css_data = false;
	
	//Load CSS data
	css_engine_player_data_load();
	
	//Load MIS devices
	mis_devices_load(engine().mis_json);
	
	//Add cursors for every player
	var _players = css_players_get_array();
	for(var i = 0; i < array_length(_players); i++)
		{
		ui_cursor_add(css_player_get(_players[@ i], CSS_PLAYER.custom).cursor, room_width div 2, room_height div 2);
		}
	
	//Create the necessary UI
	css_ui_refresh();
	}
//Clear the CSS data if there is none to load
else
	{
	css_players_clear();
	}

//Clear any engine player data
player_data_clear();
/* Copyright 2023 Springroll Games / Yosi */