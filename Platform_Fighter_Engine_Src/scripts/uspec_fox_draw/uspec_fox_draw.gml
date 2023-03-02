function uspec_fox_draw() {
	//Up Special - Draw
	if (attack_phase == 1)
		{
		fade_shader_set();
		draw_sprite_ext(spr_uspec_fox_aura, (attack_frame div 2), x, y, 2, 2, custom_attack_struct.fox_uspec_dir, c_white, 1);
		shader_reset();
		}
}
/* Copyright 2023 Springroll Games / Yosi */