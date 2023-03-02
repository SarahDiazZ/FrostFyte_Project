///@category Hitboxes
/*
Standard actions that all hitboxes should perform in the User Event 0.
By default, this script handles animating the overlay sprite and creating hitbox trails for setting().<show_hitbox_trails>.
*/
function hitbox_standard_actions() {
	//Overlay Sprite
	var _num = sprite_get_number(overlay_sprite);
	if (_num != 0)
		{
		overlay_frame = (overlay_frame + overlay_speed) % _num;
		}
		
	//Hitbox trails (debug)
	if (setting().show_hitbox_trails)	
		{
		var _vfx = vfx_create(sprite_index, 0, image_index, 60, x, y, 1, image_angle, "VFX_Layer_Below");
		_vfx.vfx_xscale = image_xscale;
		_vfx.vfx_yscale = image_yscale;
		_vfx.fade = true;
		_vfx.vfx_blend = image_blend;
		}
}
/* Copyright 2023 Springroll Games / Yosi */