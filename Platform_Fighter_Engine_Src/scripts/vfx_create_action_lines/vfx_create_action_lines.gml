///@category FX
///@param {int} lifetime			How many frames the action lines last
///@param {real} x					The x position
///@param {real} y					The y position
///@param {real} rand				The number to randomize the action lines with
///@param {string} [layer]			The layer to create the VFX on
/*
Creates an instance of <obj_action_lines> with the given properties, and returns the id.
If there is already an instance of <obj_action_lines>, that instance is destroyed first.
*/
function vfx_create_action_lines() {
	//Destroy any existing action lines
	instance_destroy(obj_action_lines);
	
	var _vfx = instance_create_layer(argument[1], argument[2], (argument_count > 4 ? argument[4] : "VFX_Layer"), obj_action_lines);
	with(_vfx)
		{
		lifetime = argument[0];
		rand = argument[3];
		total_life = lifetime;
		}
	return _vfx;
}
/* Copyright 2023 Springroll Games / Yosi */