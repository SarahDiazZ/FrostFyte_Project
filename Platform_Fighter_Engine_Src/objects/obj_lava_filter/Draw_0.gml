///@description
if (!surface_exists(surf))
	{
	surf = surface_create(room_width, room_height);
	surf_tex = surface_get_texture(surf);
	surf_tw = texture_get_texel_width(surf_tex);
	surf_th = texture_get_texel_height(surf_tex);
	clear_surf = true;
	}
if (!surface_exists(lava_surf)) 
	{
	lava_surf = surface_create(room_width, room_height);
	lava_tex = surface_get_texture(lava_surf);
	lava_tw = texture_get_texel_width(lava_tex);
	lava_th = texture_get_texel_height(lava_tex);
	clear_lava_surf = true;
	}
	
//Clearing the surface
if (!setting().performance_mode)
	{
	if (clear_surf)
		{
		clear_surf = false;
		surface_set_target(surf);
		draw_clear_alpha(c_white, 0);
		surface_reset_target();
		}
	if (clear_lava_surf)
		{
		clear_lava_surf = false;
		surface_set_target(lava_surf);
		draw_clear(c_red);
		var _w = surface_get_width(lava_surf);
		var _h = surface_get_height(lava_surf);
		repeat(250) 
			{
			draw_set_color(make_color_hsv(irandom_range(0, 40), 255, 250));
			draw_set_alpha(random_range(0.1, 0.6));
			draw_circle(irandom_range(0, _w), irandom_range(0, _h), irandom_range(10, 30), false);
			}
		surface_reset_target();
		}

	//Update lava
	if (surface_exists(lava_surf)) 
		{
		surface_set_target(lava_surf);
		var _w = surface_get_width(lava_surf);
		var _h = surface_get_height(lava_surf);
		repeat(10) 
			{
			draw_set_color(make_color_hsv(irandom_range(0, 38), 255, 250));
			draw_set_alpha(random_range(0.1, 0.7));
			draw_circle(irandom_range(0, _w), irandom_range(0, _h), irandom_range(1, 15), false);
			}
		draw_set_color(c_white);
		draw_set_alpha(1);
		surface_reset_target();
		}
	}
	
//Draw the other surface to the game surface
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Draw it with a shader applied
	if (!setting().performance_mode && !setting().disable_shaders)
		{
		shader_set(shd_lava);
		texture_set_stage(samp, lava_tex);
		shader_set_uniform_f(uni_t, lava_tw, lava_th);
		shader_set_uniform_f(uni_b, surf_tw, surf_th);
		shader_set_uniform_f(uni_i, time);
		shader_set_uniform_f(uni_f, background_get_clear_amount());
		}
	
	draw_surface(surf, 0, 0);
	
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */