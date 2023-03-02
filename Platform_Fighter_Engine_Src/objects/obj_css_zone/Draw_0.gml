///@description
//Surface
if (!surface_exists(surf))
	{
	surf = surface_create(sprite_width, sprite_height);
	surf_drawn = false;
	}
	
if (!surf_drawn)
	{
	surf_drawn = true;
	
	surface_set_target(surf);
	draw_clear_alpha(c_white, 0);
	
	//Character
	if (!setting().disable_shaders)
		{
		palette_shader_simple_set
			(
			palette_base,
			palette_swap,
			);
		draw_sprite_ext(sprite, 0, sprite_width div 2, sprite_height div 2, css_character_sprite_scale, css_character_sprite_scale, 0, c_white, 1);
		shader_reset();
		}
	else
		{
		var _blend = palette_color_get(palette_data, 0, 1);
		draw_sprite_ext(sprite, 0, sprite_width div 2, sprite_height div 2, css_character_sprite_scale, css_character_sprite_scale, 0, _blend, 1);
		}
		
	surface_reset_target();
	}

//Selected animation
image_blend = merge_color($444444, $666666, selected_animation_time);
selected_animation_time = lerp(selected_animation_time, 0, 0.1);
draw_set_color(c_white);
draw_set_alpha(selected_animation_time);
draw_rectangle(bbox_left - 4, bbox_top - 4, (bbox_right - 1) + 4, (bbox_bottom - 1) + 4, false);
draw_set_alpha(1);

draw_self();

//Surface
draw_surface(surf, x, y);

//Name
draw_set_font(fnt_consolas);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(1);
draw_text(x + (sprite_width div 2), y + sprite_height - 24, name);
/* Copyright 2023 Springroll Games / Yosi */