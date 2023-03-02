///@category Clips
///@param {string} filename			The name of the clip (do not include a file extension)
/*
To be called by <obj_game>.
This saves a GIF file using the data stored in the "clip_array" variable to the specified file name.
The number of frames saved is determined by <clip_length>.
The quality is determined by <clip_quality>.
*/
function clip_save_finish() {
	var _name = argument[0];
	if (!is_undefined(clip_gif))
		{
		gif_save(clip_gif, _name + ".gif");
		clip_gif = undefined;
		clip_saving_progress = -1;
		clip_is_saving = false;
		}
	else crash("[clip_save_finish] Invalid clip_gif (", clip_gif, ")");
}
/* Copyright 2023 Springroll Games / Yosi */