///@category Collisions
/*
Ensures that the calling player object's hsp and vsp variables are integers.
This function also stores the fractional value, allowing players to move at uneven intervals over time.
For example, a player that is continuously setting its hsp to 3.5 will move 3 pixels and then 4 pixels, alternating.
*/
function speed_fraction() {
	//Add in fractions
	hsp += hsp_frac;
	vsp += vsp_frac;
	//Re-calculate fractions
	hsp_frac = (hsp - (floor(abs(hsp)) * sign(hsp)));
	vsp_frac = (vsp - (floor(abs(vsp)) * sign(vsp)));
	//Get rid of fractions
	hsp -= hsp_frac;
	vsp -= vsp_frac;
	hsp = floor(hsp);
	vsp = floor(vsp);
}
/* Copyright 2023 Springroll Games / Yosi */