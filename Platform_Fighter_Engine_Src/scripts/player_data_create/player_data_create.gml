///@category Player Engine Scripts
///@param {int} character			The index of the character the player is using
///@param {int} color				The color the player is using
///@param {int} device				The device port
///@param {int} device_type			The device type, from the DEVICE enum
///@param {int} profile				The index of the profile the player is using
///@param {bool} is_random			Whether the player chose random or not
///@param {bool} is_cpu				Whether the player is a CPU or not
///@param {int} cpu_type			The CPU's type
///@param {int} team				The team the player is on
///@param {struct} [custom]			A struct with any values in it
/*
Creates a new player data array with the given properties, and adds it to the engine().<player_data> array.
Player data is the data stored for each player during matches, as opposed to CSS player data, which is the data stored on the character select screen.
Please note: Adding more player data after the start of a match will not add more players to the match; player data is only used in <players_spawn>.
*/
function player_data_create() {
	assert(argument_count > 8, "[player_data_create] Not enough arguments (", argument_count, ")");
	var _new = [];
	_new[@ PLAYER_DATA.character	] = argument[0];
	_new[@ PLAYER_DATA.color		] = argument[1];
	_new[@ PLAYER_DATA.device		] = argument[2];
	_new[@ PLAYER_DATA.device_type	] = argument[3];
	_new[@ PLAYER_DATA.profile		] = argument[4];
	_new[@ PLAYER_DATA.is_random	] = argument[5];
	_new[@ PLAYER_DATA.is_cpu		] = argument[6];
	_new[@ PLAYER_DATA.cpu_type		] = argument[7];
	_new[@ PLAYER_DATA.team			] = argument[8];
	_new[@ PLAYER_DATA.custom		] = argument_count > 9 ? argument[9] : {};
	array_push(engine().player_data, _new);
	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */