function passive4() {
	//Neutral B
	if (!variable_struct_exists(custom_passive_struct, "has_kunai"))
		{
		custom_passive_struct.has_kunai = true;
		}
		
	if (on_ground() || is_knocked_out())
		{
		custom_passive_struct.has_kunai = true;
		attack_uses_set(1, nspec4);
		}
	else if (state == PLAYER_STATE.aerial && jump_is_midair_jump && state_time == 0)
		{
		custom_passive_struct.has_kunai = true;
		attack_uses_set(1, nspec4);
		}
	if (state == PLAYER_STATE.wall_cling || state == PLAYER_STATE.wall_jump)
		{
		custom_passive_struct.has_kunai = true;
		attack_uses_set(1, nspec4);
		}
		
	//Special Entrance
	if (state == PLAYER_STATE.entrance && state_time == 1)
		{
		var _vfx = vfx_create(spr_dust_poof, 1, 0, 28, x, y, 2, 0, "VFX_Layer_Below");
		_vfx.vfx_xscale *= prng_choose(0, -1, 1);
		_vfx.vfx_yscale *= prng_choose(1, -1, 1);
		}
}
/* Copyright 2023 Springroll Games / Yosi */