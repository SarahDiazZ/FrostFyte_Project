///@category Hurtboxes
/*
Updates the invulnerability for the calling hurtbox.
If the invulnerability frame reaches 0, the invulnerability is set back to INV.normal.
*/
function hurtbox_inv_update() {
	if (inv_type != INV.normal && inv_frame == 0)
		{
		inv_type = INV.normal;
		inv_override = true;
		}	
	inv_frame -= 1;
}
/* Copyright 2023 Springroll Games / Yosi */