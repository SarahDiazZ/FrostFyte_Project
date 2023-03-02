///@category Backgrounds
///@param {int} length				How many frames the background fade will last
///@param {color} color				What color the background will fade to
///@param {int} [direction]			The direction to draw lines in
///@param {real} [fade_speed]		How fast the background will fade
/*
Triggers the background fade effect and the player darken effect.
If no direction is given, the background clear will be drawn without direction lines.
*/
function background_clear_activate() {
	with(obj_stage_manager)
		{
		background_clear_frame = argument[0];
		background_clear_color = argument[1];
		background_clear_direction = argument_count > 2 ? round(modulo(argument[2], 360)) : -1;
		background_clear_fade_speed = argument_count > 3 ? argument[3] : 1.0;
		background_clear_amount = max(background_clear_amount, 0);
		}
	
	with(obj_player)
		{
		fade_value = 0;
		}
}
/* Copyright 2023 Springroll Games / Yosi */