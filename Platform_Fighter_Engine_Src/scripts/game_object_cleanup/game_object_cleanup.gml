///@category Gameplay
/*
This function is ONLY intended to be called by <obj_game> and <obj_game_online> during the Clean Up events.
It cleans up all of the dynamic data structures created by the object.
*/
function game_object_cleanup() {
	ds_priority_destroy(hitbox_priority_queue);
	ds_list_destroy(player_depth_list);
	ds_list_destroy(ordered_player_list);
	surface_free(game_surface);
	surface_free(offscreen_view_surface);
	buffer_delete(game_state_buffer);
	surface_free(clip_surface);
	surface_free(cam_surface);
	if (clip_can_record())
		{
		for(var i = 0; i < clip_length; i++)
			{
			buffer_delete(clip_array[@ i]);
			clip_array[@ i] = noone;
			}
		}

	hitbox_priority_queue = noone;
	player_depth_list = noone;
	ordered_player_list = noone;
	game_surface = noone;
	offscreen_view_surface = noone;
	game_state_buffer = noone;
	clip_surface = noone;
	cam_surface = noone;

	view_camera[0] = -1;

	gc_collect();
}

/* Copyright 2023 Springroll Games / Yosi */