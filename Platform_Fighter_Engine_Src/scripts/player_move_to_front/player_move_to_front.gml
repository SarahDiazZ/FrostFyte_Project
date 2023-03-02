///@category Player Rendering
/*
Changes a player to be drawn above other players assigned to the same <obj_player_renderer>.
*/
function player_move_to_front() {
	ds_list_re_add(obj_game.player_depth_list, id);
}
/* Copyright 2023 Springroll Games / Yosi */