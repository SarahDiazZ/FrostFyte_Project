///@category Backgrounds
/*
Turns on the fade shader, which fades an object based on how cleared the background is.
Requires <obj_stage_manager> to be in the room.
*/
function fade_shader_set() {
	if (instance_exists(obj_stage_manager) && !setting().disable_shaders)
		{
		shader_set(shd_fade);
		shader_set_uniform_f(obj_stage_manager.uni_black, (1 - obj_stage_manager.background_clear_amount));
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */