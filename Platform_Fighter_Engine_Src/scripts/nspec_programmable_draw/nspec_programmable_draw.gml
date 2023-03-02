function nspec_programmable_draw() {
	//Neutral Special - Draw
	if (attack_phase == 1)
		{
		draw_set_color(c_white);
		var tx = 0, ty = 0;
		for(var i = 0; i < array_length(custom_attack_struct.program); i++)
			{
			tx += lengthdir_x(100, custom_attack_struct.program[i]);
			ty += lengthdir_y(100, custom_attack_struct.program[i]);
			draw_circle(x + tx, y + ty, 4, false);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */