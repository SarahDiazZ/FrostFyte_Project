///@description Debug
if (setting().debug_mode_enable)
	{
	//Special Debug Menus
	if (keyboard_check_pressed(vk_f1))
		{
		debug_menus.resources ^= 1;
		}
	if (keyboard_check_pressed(vk_f2))
		{
		debug_menus.overlay ^= 1;
		show_debug_overlay(debug_menus.overlay);
		}
	if (keyboard_check_pressed(vk_f3))
		{
		debug_menus.inputs ^= 1;
		}
	if (keyboard_check_pressed(vk_f4))
		{
		debug_menus.overhead ^= 1;
		}
	if (keyboard_check_pressed(vk_f9))
		{
		debug_menus.sync_ids ^= 1;
		}
	
	//Visibility
	if (keyboard_check_pressed(vk_f5))
		{
		setting().show_hitboxes ^= 1;
		}
	if (keyboard_check_pressed(vk_f6))
		{
		setting().show_hurtboxes ^= 1;
		}
	if (keyboard_check_pressed(vk_f7))
		{
		setting().show_collision_boxes ^= 1;
		}
	if (keyboard_check_pressed(vk_f8))
		{
		setting().show_launch_trajectories ^= 1;
		with(obj_launch_trajectory_point)
			{
			instance_destroy();
			}
		}
		
	//Resource counts (every 1/6 of a second)
	if (debug_menus.resources && current_frame % 10 == 0)
		{
		resource_counts = dynamic_resource_count_all();
		}
		
	//Garbage collector
	if (keyboard_check_pressed(vk_f10))
		{
		show_debug_message(gc_get_stats());
		}
		
	//Live Values
	if (keyboard_check_pressed(vk_f11))
		{
		live_values_reload();
		}
		
	//Green Screen
	if (keyboard_check_pressed(vk_f12))
		{
		setting().green_screen_color += 1;
		if (setting().green_screen_color > 5) then setting().green_screen_color = 0;
		}
	}
	
//FPS (update every second)
if (setting().debug_fps && current_frame % 60 == 0 && state == GAME_STATE.normal)
	{
	fps_min = min(fps_min, fps_real);
	fps_max = max(fps_max, fps_real);
	fps_avg = is_undefined(fps_avg) ? fps_real : fps_avg + ((fps_real - fps_avg) / current_frame);
	}
/* Copyright 2023 Springroll Games / Yosi */