///@category Player Rendering
/*
Changes a player to be drawn below other players assigned to the same <obj_player_renderer>.
*/
function player_move_to_back() {
	ds_list_re_add(obj_game.player_depth_list, id, true)
}
/* Copyright 2023 Springroll Games / Yosi */