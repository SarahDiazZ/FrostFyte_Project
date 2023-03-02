///@description
//Move
x += hsp;
y += vsp;

//Friction
hsp *= 0.65;
vsp *= 0.65;
	
//Shrinking
if (shrink != 0)
	{
	vfx_xscale *= shrink;
	vfx_yscale *= shrink;
	}
	
//Fading
if (lifetime <= 10)
	{
	image_alpha = lifetime / 10;
	}

//lifetime / Time
if (--lifetime < 0 || setting().performance_mode)
	{
	instance_destroy();
	}
/* Copyright 2023 Springroll Games / Yosi */