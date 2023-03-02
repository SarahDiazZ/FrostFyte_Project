///@category Clips
/*
To be called by <obj_game>.
Adds the next frame to the GIF that is currently being saved after <clip_save_start> is called.
If there are no frames left to save, nothing will be added to the GIF, and the function will return false to let you know <clip_save_finish> should be called.
The number of frames saved is determined by <clip_length>.
The quality is determined by <clip_quality>.
*/
function clip_save_frame_add() {
	assert(clip_is_saving, "[clip_save_frame_add] The variable clip_is_saving must be true");
	assert(!is_undefined(clip_gif), "[clip_save_frame_add] The variable clip_gif cannot be undefined");
	
	if (clip_saving_progress >= clip_length) then return false;
	
	var _frame = modulo(clip_frame + clip_saving_progress, clip_length);

	//Make sure the surface exists
	if (!surface_exists(clip_surface))
		{
		clip_surface = surface_create(screen_width, screen_height);
		}
		
	//Load the buffer contents onto the surface
	buffer_set_surface(clip_array[@ _frame], clip_surface, 0);

	//Add to the GIF
	var _delays = [3, 3, 4];
	gif_add_surface(clip_gif, clip_surface, _delays[@ _frame % 3], 0, clip_quality);
	clip_saving_progress++;

	return true;
}
/* Copyright 2023 Springroll Games / Yosi */