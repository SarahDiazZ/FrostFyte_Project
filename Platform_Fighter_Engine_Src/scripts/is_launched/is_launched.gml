///@category Player Actions
///@param {id} [player]			The player to check
/*
Returns true if the given player is in a "launched" state:
	- PLAYER_STATE.hitlag
	- PLAYER_STATE.hitstun
	- PLAYER_STATE.balloon
	- PLAYER_STATE.magnetized
	- PLAYER_STATE.flinch
	- PLAYER_STATE.knockdown
*/
function is_launched() {
	var _p = argument_count > 0 ? argument[0] : id;
	return 
		_p.state == PLAYER_STATE.balloon		||
		_p.state == PLAYER_STATE.flinch		||
		_p.state == PLAYER_STATE.hitlag		||
		_p.state == PLAYER_STATE.hitstun		||
		_p.state == PLAYER_STATE.magnetized;
}
/* Copyright 2023 Springroll Games / Yosi */