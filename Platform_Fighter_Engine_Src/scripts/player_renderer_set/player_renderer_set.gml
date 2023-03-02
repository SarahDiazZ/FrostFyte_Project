///@category Player Rendering
///@param {int} renderer			The object index of the renderer to assign the player to
/*
Sets the player's renderer. By default you can choose either <obj_player_renderer>, <obj_player_renderer_foreground>, or <obj_player_renderer_background>.
Please note: In the room template, there is exacctly one instance of each player renderer object. If you add duplicates of a renderer, or delete a renderer, this function may not work as expected.
*/
function player_renderer_set() {
	if (instance_exists(argument[0]))
		{
		renderer = argument[0];
		}
}
/* Copyright 2023 Springroll Games / Yosi */