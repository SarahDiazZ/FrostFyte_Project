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
		case 0: return #5dec23; break; // cursor and player 1 # green
        case 1: return #ff962b; break; // player 2 #orange
        case 2: return #fb3721; break; // red
        case 3: return #217dfb; break; // blue
        case 4: return #fdff2b; break; // yellow
        case 5: return #FFFFFF; break; // white
        case 6: return #922bff; break; // purple
        case 7: return #2bffcf; break; // turq
        default: return #fb3721; // the default max #red
		}
}
/* Copyright 2023 Springroll Games / Yosi */