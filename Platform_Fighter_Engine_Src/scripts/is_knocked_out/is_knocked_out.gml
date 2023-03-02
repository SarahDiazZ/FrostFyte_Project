///@category Player Actions
///@param {id} [player]			The player to check
/*
Returns true if the given player is in a "dead" state:
	- PLAYER_STATE.knocked_out
	- PLAYER_STATE.star_ko
	- PLAYER_STATE.screen_ko
	- PLAYER_STATE.lost
*/
function is_knocked_out() {
	var _p = argument_count > 0 ? argument[0] : id;
	return 
		_p.state == PLAYER_STATE.knocked_out	||
		_p.state == PLAYER_STATE.star_ko		||
		_p.state == PLAYER_STATE.screen_ko		||
		_p.state == PLAYER_STATE.lost;
}
/* Copyright 2023 Springroll Games / Yosi */