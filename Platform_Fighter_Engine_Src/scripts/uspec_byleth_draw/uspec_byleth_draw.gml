function uspec_byleth_draw() {
	//Sword of the Creator
	if (attack_phase == 2 && attack_frame >= 20)
		{
		var _col = palette_color_get(palette_data, 1);
		fade_shader_set();
		
		//Tether line
		var _dir = point_direction(x, y, grabbed_id.x, grabbed_id.y);
		var _len = point_distance(x, y, grabbed_id.x, grabbed_id.y);
		draw_line_sprite(x, y, grabbed_id.x, grabbed_id.y, 6, c_black);
		draw_line_sprite(x, y, grabbed_id.x, grabbed_id.y, 2, _col);

		shader_reset();
		
		draw_sprite(spr_tether_target, 0, grabbed_id.x, grabbed_id.y);
		}
	else if (attack_phase == 1 || attack_phase == 3)
		{
		var _col = palette_color_get(palette_data, 1);
		fade_shader_set();
		
		//Tether line
		var _dir = point_direction(x, y, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y);
		var _len = point_distance(x, y, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y);
		draw_line_sprite(x, y, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y, 6, c_black);
		draw_line_sprite(x, y, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y, 2, _col);

		shader_reset();
		
		draw_sprite(spr_tether_target, 0, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y);
		}
}
/* Copyright 2023 Springroll Games / Yosi */