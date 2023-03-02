///@category Player Engine Scripts
///@param {int} number			The player's number
///@param {bool} [is_cpu]		Whether the player is a CPU or not (which will return gray)
/*
Gets the color used for a specific player slot in menus / UI / HUD.
If the player is a CPU, the color will always be gray.
*/
function player_color_get() {
	if (argument_count > 1 && argument[1]) then return $aeaeae;

	switch(argument[0])
		{
		case 0: return $5959E0; break;
		case 1: return $DD8A56; break;
		case 2: return $32E0FF; break;
		case 3: return $2DFF62; break;
		case 4: return $FF70C3; break;
		case 5: return $FFF070; break;
		case 6: return $995BE5; break;
		case 7: return $5A9AE2; break;
		default: return $FFFFFF; //Returns pure white for player numbers higher than 7, the default max.
		}
}
/* Copyright 2023 Springroll Games / Yosi */