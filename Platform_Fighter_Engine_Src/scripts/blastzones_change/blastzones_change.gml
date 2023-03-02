///@category Collisions
///@param {int} left		The x coordinate of the left blastzone
///@param {int} top			The y coordinate of the top blastzone
///@param {int} right		The x coordinate of the right blastzone
///@param {int} bottom		The y coordinate of the bottom blastzone
/*
Sets all of the blastzones to the specified values.
<obj_stage_manger> must be in the room for this function to work.
*/
function blastzones_change() {
	with(obj_stage_manager)
		{
		blastzones.left = argument[0];
		blastzones.top = argument[1];
		blastzones.right = argument[2];
		blastzones.bottom = argument[3];
		return true;
		}
	crash("obj_stage_manager did not exist when blastzones_reset was called");
}
/* Copyright 2023 Springroll Games / Yosi */