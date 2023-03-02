///@category Clips
/*
To be called by <obj_game>.
This adds the contents of the game surface (or the application surface, if the game surface is disabled) to the "clip_array" variable
A GIF can later be created from this data using <Clip_Save>.
The number of frames saved is determined by <clip_length>.
*/
function clip_frame_add() {
	//Clip surface
	if (!surface_exists(clip_surface))
		{
		clip_surface = surface_create(screen_width, screen_height);
		}

	//Choose which surface to save
	var _s = undefined;
	if (camera_can_zoom() && surface_exists(cam_surface))
		{
		_s = cam_surface;
		}
	else if (game_surface_enable && surface_exists(game_surface))
		{
		_s = game_surface;
		}
	else if (surface_exists(application_surface))
		{
		_s = application_surface;
		}
	
	//Save the data to the buffer
	if (!is_undefined(_s))
		{
		var _b = clip_array[@ clip_frame];
		if (!is_undefined(_b) && buffer_exists(_b))
			{
			if (camera_can_zoom())
				{
				buffer_get_surface(_b, _s, 0);
				}
			else
				{
				surface_copy_part(clip_surface, 0, 0, _s, cam_x, cam_y, screen_width, screen_height);
				buffer_get_surface(_b, clip_surface, 0);
				}
			}
		clip_frame = modulo(clip_frame + 1, array_length(clip_array));
		}
}
/* Copyright 2023 Springroll Games / Yosi */