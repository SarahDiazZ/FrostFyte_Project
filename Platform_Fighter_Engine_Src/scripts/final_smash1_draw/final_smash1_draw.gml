///Final Smash for character1 - Draw
function final_smash1_draw() {
	var _accent = palette_color_get(palette_data, 1);
	draw_sprite_ext(spr_final_smash1_reticle, 0 + ((attack_frame / 6) % 3), custom_attack_struct.final_smash_x, custom_attack_struct.final_smash_y, 2, 2, 0, _accent, 1);
	for(var i = 0; i < array_length(custom_ids_struct.final_smash_targets); i++)
		{
		var _target = custom_ids_struct.final_smash_targets[@ i];
		if (_target.state != PLAYER_STATE.lost)
			{
			draw_sprite_ext(spr_final_smash1_reticle, 3 + ((attack_frame / 6) % 3), _target.x, _target.y, 2, 2, 0, _accent, 1);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */