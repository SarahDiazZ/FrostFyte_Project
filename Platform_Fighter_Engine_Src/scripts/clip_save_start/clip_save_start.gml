///@category Clips
/*
To be called by <obj_game>.
This starts the process of saving a GIF file using the data stored in the "clip_array" variable.
The game meta state will be set to GAME_META_STATE.saving_clip while the GIF is being exported.
<Clip_Save_Frame> can be called to save each individual frame, and <clip_save_finish> to save the final GIF file with all of the frames added.
The number of frames saved is determined by <clip_length>.
The quality is determined by <clip_quality>.
*/
function clip_save_start() {
	//Create the gif
	clip_gif = gif_open(screen_width, screen_height);
	clip_saving_progress = 0;
	clip_is_saving = true;
	meta_state = GAME_META_STATE.saving_clip;
}
/* Copyright 2023 Springroll Games / Yosi */