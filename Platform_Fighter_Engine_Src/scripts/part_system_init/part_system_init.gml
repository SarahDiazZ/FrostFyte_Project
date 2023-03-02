///@category Startup
/*
Initializes the particle system.
This function is automatically called once in <engine_init>.
*/
function part_system_init() {
	part_system_depth(Particle_System(), -100);
	part_system_automatic_update(Particle_System(), false);
	part_system_automatic_draw(Particle_System(), false);

	//Snow Particles
	part_type_sprite(Particle_Type_Snow(), back_peak_snow, false, false, true);
	part_type_size(Particle_Type_Snow(), 0.1, 2, -0.01, 0.01);
	part_type_life(Particle_Type_Snow(), 600, 800);
	part_type_alpha2(Particle_Type_Snow(), 1, 0);
}

/* SYSTEM */
function Particle_System() {
	static _system = part_system_create();
	return _system;
}

/* TYPES */
function Particle_Type_Snow() {
	static _type = part_type_create();
	return _type;
}


/* Copyright 2023 Springroll Games / Yosi */