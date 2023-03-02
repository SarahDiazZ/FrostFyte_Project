///@category Character Select Screen
///@param {int} device				The device port
///@param {int} device_type			The device type, from the DEVICE enum
///@param {int} profile				The profile index the player uses
///@param {bool} cpu				Whether the player is a CPU or not
///@param {struct} [custom]			Any custom data
/*
Adds a new player to the character select screen with the given values.
Returns the player's id number in the CSS.
*/
function css_player_add() {
	var _device = argument[0];
	var _device_type = argument[1];
	var _profile = argument[2];
	var _cpu = argument[3];
	var _custom = argument_count > 4 ? argument[4] : undefined;
		
	var _character = character_find("Random"); //Default to Random
	var _id = engine().css_index_current;
	var _ready = false;
		
	if (array_length(engine().css_player_data) < max_players)
		{
		//CPU defaults
		if (_cpu)
			{
			_ready = true;
			_device = -1;
			_device_type = DEVICE.none;
			}
				
		//Create the array
		var _new = [];
		_new[@ CSS_PLAYER.character] = _character;
		_new[@ CSS_PLAYER.color] = css_character_color_get_next(_id, _character, 0, 1);
		_new[@ CSS_PLAYER.cpu_type] = CPU_TYPE.attack;
		_new[@ CSS_PLAYER.custom] = _custom;
		_new[@ CSS_PLAYER.device] = _device;
		_new[@ CSS_PLAYER.device_type] = _device_type;
		_new[@ CSS_PLAYER.is_cpu] = _cpu;
		_new[@ CSS_PLAYER.player_id] = _id;
		_new[@ CSS_PLAYER.profile] = _profile;
		_new[@ CSS_PLAYER.team] = 0;
		array_push(engine().css_player_data, _new);
			
		//Change the index so there are no overlaps
		engine().css_index_current += 1;
			
		//Return the id
		return _id;
		}
	else
		{
		return undefined;
		}
}
/* Copyright 2023 Springroll Games / Yosi */