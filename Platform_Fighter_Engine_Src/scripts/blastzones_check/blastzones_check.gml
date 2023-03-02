///@category Collisions
///@param {bool} [count_top_blastzone]		Whether to always count the top border
/*
Returns true if the calling object is completely outside the blastzones.
If the calling object is <obj_player>, the top blastzone is only counted if the player is standing on the ground, in hitstun, or if the argument "count_top_blastzone" is true.
<obj_stage_manger> must be in the room for this function to work.
*/
function blastzones_check() {
	assert(instance_exists(obj_stage_manager), "[blastzones_check] obj_stage_manager must exist for this function to work");
	//If you are outside the blastzone on the left, right, or bottom
	if ((bbox_right - 1) < obj_stage_manager.blastzones.left ||
		bbox_left > obj_stage_manager.blastzones.right ||
		bbox_top > obj_stage_manager.blastzones.bottom)
		{
		return true;
		}

	//If you are in hitstun and outside the blastzone on the top
	var _count_top = argument_count > 0 ? argument[0] : on_ground();
	var _player_in_hitstun = object_is(object_index, obj_player) && (state == PLAYER_STATE.hitstun || state == PLAYER_STATE.balloon || is_knocked_out());
	if (_count_top || _player_in_hitstun)
		{
		if ((bbox_bottom - 1) < obj_stage_manager.blastzones.top)
			{
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */