///@description
draw_point(mouse_x, mouse_y);

draw_circle(x, y, 100, false);
draw_line_width_color(x, y, x + lengthdir_x(100, kb_angle), y + lengthdir_y(100, kb_angle), 4, c_red, c_red);
draw_line_width_color(x, y, x + lengthdir_x(100, stick_angle), y + lengthdir_y(100, stick_angle), 4, c_blue, c_blue);
draw_line_width_color(x, y, x + lengthdir_x(200, di_angle), y + lengthdir_y(200, di_angle), 4, c_lime, c_lime);

draw_set_font(fnt_consolas);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_rectangle_color(16, 16, 180, 128, c_ltgray, c_ltgray, c_ltgray, c_ltgray, false);
draw_text_color(32, 32, to_string("Knockback: ", kb_angle), c_red, c_red, c_red, c_red, 1);
draw_text_color(32, 64, to_string("Stick: ", stick_angle), c_blue, c_blue, c_blue, c_blue, 1);
draw_text_color(32, 96, to_string("Final DI: ", di_angle), c_lime, c_lime, c_lime, c_lime, 1);
/* Copyright 2023 Springroll Games / Yosi */