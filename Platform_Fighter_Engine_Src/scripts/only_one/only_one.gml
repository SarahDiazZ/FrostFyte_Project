/*
Crahes the game if there are more than one instance of the calling object in the room.
This is useful in manager/controller objects that could cause stealthy errors if there were multiple instances at the same time.
*/
function only_one() {
	//If there's more than one of the instance, crash
	if (instance_number(object_index) > 1)
		{
		crash("[only_one] There can only be one instance of " + object_get_name(object_index) + " at a time!");
		}
}
/* Copyright 2023 Springroll Games / Yosi */