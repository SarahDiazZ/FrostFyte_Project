function stage_clouds_lightning() {
	//Lightning
	if (!variable_struct_exists(custom_stage_struct, "lightning_timer"))
		{
		custom_stage_struct.lightning_timer = 0;
		}
	if (custom_stage_struct.lightning_timer == 0)
		{
		custom_stage_struct.lightning_timer = prng_number(0, 300, 180);
		vfx_create
			(
			back_clouds_bolt, 
			0, 
			prng_number(1, 2), 
			15, 
			prng_number(2, obj_game.cam_x + obj_game.cam_w, obj_game.cam_x), 
			0,
			2,
			0,
			"VFX_Layer_Below",
			);
		stage_tint = [-1.0, -1.0, -1.0];
		}
	else
		{
		custom_stage_struct.lightning_timer = max(custom_stage_struct.lightning_timer - 1, 0);
		stage_tint[@ 0] = lerp(stage_tint[@ 0], 0, 0.1);
		stage_tint[@ 1] = lerp(stage_tint[@ 1], 0, 0.1);
		stage_tint[@ 2] = lerp(stage_tint[@ 2], 0, 0.1);
		}
}
/* Copyright 2023 Springroll Games / Yosi */