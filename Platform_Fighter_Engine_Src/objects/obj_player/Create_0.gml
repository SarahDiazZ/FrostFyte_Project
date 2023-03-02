///@category Gameplay
/*
obj_player is the object for every player in the game.
Similarly to other <GAME_STATE_OBJECT>, obj_player has no Step event and instead relies on <obj_game> to call its User Events. Additionally, obj_player has no Draw event and is rendered by <obj_player_renderer>.
The variables for obj_player can be found in <player_init_start>, <player_init_end>, and the character init scripts.
Please note: Any players created after the match has already started will crash the game if they don't have every variable initialized properly. See <players_spawn> to know which variables need to be set.
*/
///@description Init

GAME_STATE_OBJECT

sync_id_assign();

player_init_start();

/* Copyright 2023 Springroll Games / Yosi */