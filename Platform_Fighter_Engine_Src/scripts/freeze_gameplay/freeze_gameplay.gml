///@category Gameplay
///@param {int} frames				The number of frames to freeze gameplay for
///@param {bool} [freeze_self]		Whether to freeze the calling object or not
/*
This function "freezes" all gameplay objects by setting their "self_hitlag_frame" variables.
By default, the calling object will include itself.
*/
function freeze_gameplay() {
	var _frames = argument[0];
	var _self = argument_count > 1 ? argument[1] : true;
	
	//This does NOT need to be synced for rollback
	with(obj_player)
		{
		if (!_self && id == other.id) then continue;
		self_hitlag_frame = _frames;
		}
	with(obj_entity)
		{
		if (!_self && id == other.id) then continue;
		self_hitlag_frame = _frames;
		}
	with(obj_hitbox_projectile)
		{
		if (!_self && id == other.id) then continue;
		self_hitlag_frame = _frames;
		}
}
/* Copyright 2023 Springroll Games / Yosi */