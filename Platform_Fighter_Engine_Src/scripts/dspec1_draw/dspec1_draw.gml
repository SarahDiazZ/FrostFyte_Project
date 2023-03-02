function dspec1_draw() {
	if (attack_phase == 1)
		{
		var _a = attack_frame > 30 ? lerp(1, 0, (attack_frame - 30) / 10) : lerp(0, 1, attack_frame / 30);
		var _c = palette_color_get(palette_data, 1);
		
		draw_primitive_begin(pr_trianglestrip);
		
		var _outside = 224;
		var _inside = 125;
		var _angle = 0;
		
		for(var i = 0; i < 31; i++)
			{
			draw_vertex_color(x + lengthdir_x(_outside, _angle), y + lengthdir_y(_outside, _angle), _c, _a);
			draw_vertex_color(x + lengthdir_x(_inside, _angle), y + lengthdir_y(_inside, _angle), _c, _a);
			_angle += 12;
			}
			
		draw_primitive_end();
		}
	//EX
	if (attack_phase == 2 && attack_frame > 20)
		{
		fade_shader_set();
		var _c = palette_color_get(palette_data, 1);
		draw_sprite_ext(spr_hit_counter, 32 - attack_frame, x, y, 2, 2, 0, _c, 1);
		shader_reset();
		}
}
/* Copyright 2023 Springroll Games / Yosi */