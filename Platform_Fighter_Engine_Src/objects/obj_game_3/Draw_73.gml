///@description Game Surface, Offscreen Surface, Clips
//Camera surface
if (camera_can_zoom() && (!surface_exists(view_get_surface_id(0)) || view_get_surface_id(0) != cam_surface))
	{
	if (!surface_exists(cam_surface))
		{
		cam_surface = surface_create(screen_width, screen_height);
		}
	view_set_surface_id(0, cam_surface);
	}

//Make sure the surface exists first
if (!surface_exists(game_surface))
	{
	game_surface = surface_create(room_width, room_height);
	}
	
//Particle System Draw
if (game_surface_enable) surface_set_target(game_surface);

fade_shader_set();
part_system_drawit(Particle_System());
shader_reset();

if (game_surface_enable) surface_reset_target();

//Draw the new surface
if (game_surface_enable)
	{
	gpu_set_blendenable(false);
	
	//Screen shader / Daynight shader
	if (setting().screen_shader_script != -1 && 
		!setting().disable_shaders && 
		!setting().performance_mode)
		{
		script_execute(setting().screen_shader_script);
		}
	else
		{
		daynight_set();
		}
		
	//Draw the surface
	draw_surface(game_surface, 0, 0);
	
	shader_reset();
	
	gpu_set_blendenable(true);
	}
	
//Offscreen View Surface
if (surface_exists(offscreen_view_surface))
	{
	draw_surface(offscreen_view_surface, 0, 0);
	}
	
//Clips
if (clip_should_save && clip_can_record())
	{
	clip_should_save = false;
	clip_frame_add();
	}

/* Copyright 2023 Springroll Games / Yosi */