function item_bat_attack_default_draw_script() {
	//Draw Script
	if (!variable_struct_exists(custom_attack_struct, "item_bat_frame"))
		{
		custom_attack_struct.item_bat_frame = 0;
		}
		
	//Draw onto the surface
	surface_set_target(object_surface_get());
	draw_clear_alpha(c_white, 0);
	draw_sprite_ext(spr_item_bat_attack_default, custom_attack_struct.item_bat_frame, object_surface_size_half, object_surface_size_half, facing, 1, 0, c_white, 1);
	surface_reset_target();
	
	//Set up the shader and draw
	var _halfx = sprite_scale * object_surface_size_half;
	var _halfy = sprite_scale * object_surface_size_half;
	var _len = point_distance(0, 0, _halfx, _halfy);
	var _cx = lengthdir_x(_len, -45);
	var _cy = lengthdir_y(_len, -45);
	player_shader_set();
	draw_surface_ext(object_surface_get(), x - _cx, y - _cy, abs(sprite_scale), sprite_scale, 0, c_white, 1);
	shader_reset();
}
/* Copyright 2023 Springroll Games / Yosi */