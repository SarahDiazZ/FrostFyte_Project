///@category Collisions
/*
Resets all of the blastzones to the defaults, which are the borders of the room. 
<obj_stage_manger> must be in the room for this function to work.
*/
function blastzones_reset() {
	with(obj_stage_manager)
		{
		blastzones.left = 0;
		blastzones.top = 0;
		blastzones.right = room_width;
		blastzones.bottom = room_height;
		return true;
		}
	crash("obj_stage_manager did not exist when blastzones_reset was called");
}
/* Copyright 2023 Springroll Games / Yosi */