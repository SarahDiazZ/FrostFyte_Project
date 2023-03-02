///@category Hitboxes
///@param {array} [my_hitboxes]		The hitbox array to use
/*
Destroys all attached hitboxes owned by the calling player.
*/
function hitbox_destroy_attached_all() {
	//Destroys all of the attached hitboxes
	var _array = argument_count > 0 ? argument[0] : my_hitboxes;
	while(array_length(_array) > 0)
		{
		//Instances remove themselves from the array automatically if they are deleted
		if (instance_exists(_array[@ 0]))
			{
			with(_array[@ 0])
				{
				instance_destroy();
				}
			}
		else
			{
			array_delete(_array, 0, 1);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */