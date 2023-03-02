///@category Collisions
///@param {real} hsp				The horizontal speed
///@param {real} vsp				The vertical speed
///@param {bool} [hrelative]		Whether the horizontal speed is a relative boost or not
///@param {bool} [vrelative]		Whether the vertical speed is a relative boost or not
/*
Sets the speed of the player using the given horizontal and vertical components.
By default, the player's speed will be set exactly to the hsp and vsp arguments.
If the "relative" arguments are set to true, the hsp/vsp will instead be added to the current hsp/vsp.
*/
function speed_set() {
	//You can set it relative to the current speed (+=) or to an absolute value (=)
	if (argument_count > 2 && argument[2])
		{
		hsp += argument[0];
		}
	else
		{
		hsp = argument[0];
		hsp_frac = 0;
		}
	if (argument_count > 3 && argument[3])
		{
		vsp += argument[1];
		}
	else
		{
		vsp = argument[1];
		vsp_frac = 0;
		}
}
/* Copyright 2023 Springroll Games / Yosi */