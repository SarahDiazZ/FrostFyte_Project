///@description	
	
//Draw to the game surface with the shader
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	if (!setting().performance_mode && !setting().disable_shaders)
		{
		if (obj_stage_manager.custom_stage_struct.haven_final_form)
			{
			shader_set(shd_haven_final);
			shader_set_uniform_f(shader_get_uniform(shd_haven_final, "time"), (obj_game.current_frame / 100) + 50);
			shader_set_uniform_f(shader_get_uniform(shd_haven_final, "fade_amount"), background_get_clear_amount());
			}
		else
			{
			shader_set(shd_fade);
			shader_set_uniform_f(shader_get_uniform(shd_fade, "fade_amount"), background_get_clear_amount());
			}
		}
	
	draw_self();
	
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */