///@category FX
///@param {asset} sprite			The sprite to use for the VFX
///@param {real} image_speed		The animation speed
///@param {int} index				The subimage the VFX starts on
///@param {int} lifetime			How many frames the VFX lasts
///@param {real} x					The x position
///@param {real} y					The y position
///@param {real} scale				The scale of the VFX 
///@param {real} angle				The angle of the VFX
///@param {string} [layer]			The layer to create the VFX on
/*
Creates an instance of <obj_vfx_color> with the given properties, and returns the id.
<obj_vfx_color> is essentially the same as <obj_vfx>, except it uses the palette of its owner.
*/
function vfx_create_color() {
	var _vfx = instance_create_layer(argument[4], argument[5], (argument_count > 8 ? argument[8] : "VFX_Layer"), obj_vfx_color);
	with(_vfx)
		{
		vfx_sprite = argument[0];
		vfx_speed = argument[1];
		vfx_frame = argument[2];
		lifetime = argument[3];
		vfx_xscale = argument[6];
		vfx_yscale = argument[6];
		vfx_angle = argument[7];
		total_life = lifetime;
		owner = other.id;
		}
	return _vfx;
}
/* Copyright 2023 Springroll Games / Yosi */