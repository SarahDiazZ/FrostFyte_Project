///@category Player Actions
/*
Switches the player's state to the aerial state, and performs a double jump.
This also applies a slight horizontal speed boost, based on the character's "double_jump_horizontal_accel".
Warning: This function can run even if the player has no remaining double jumps.
*/
function double_jump() {
	//State
	state_set(PLAYER_STATE.aerial);

	//Speeds
	speed_set(0, -double_jump_speed, true, false);
	double_jumps--;
	jump_is_midair_jump = true;

	//Horizontal Speed change
	if (stick_tilted(Lstick, DIR.horizontal))
		{
		hsp = clamp(hsp + (double_jump_horizontal_accel * sign(stick_get_value(Lstick, DIR.horizontal))), -max_air_speed, max_air_speed);
		hsp_frac = 0;
		}
	
	//VFX
	vfx_create(spr_dust_air_jump, 1, 0, 7, x, y, 2, 0);

	//Peak of jump
	if (abs(vsp) < 1)
		{
		anim_set(my_sprites[$ "DJumpMid"]);
		}
	//Falling
	else if (vsp >= 1)
		{
		anim_set(my_sprites[$ "DJumpFall"]);
		}
	//Rising
	else if (vsp <= 1)
		{
		anim_set(my_sprites[$ "DJumpRise"]);
		}
	//Fastfalling
	if (vsp >= floor(fastfall_speed))
		{
		anim_set(my_sprites[$ "DFastfall"]);
		}
}
/* Copyright 2023 Springroll Games / Yosi */