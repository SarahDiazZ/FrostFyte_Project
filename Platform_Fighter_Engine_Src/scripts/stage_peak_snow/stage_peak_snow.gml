///@func stage_peak_snow()
function stage_peak_snow() {
	if (setting().performance_mode) then return;
	if (game_is_in_rollback()) then return;
	part_type_direction(Particle_Type_Snow(), 235, 315, 0, 1);
	part_type_speed(Particle_Type_Snow(), 2, 4, 0, 0.1);
	part_type_orientation(Particle_Type_Snow(), 0, 360, 0, 0, false);
	part_particles_create(Particle_System(), random(room_width), obj_game.cam_y, Particle_Type_Snow(), 4);
}
/* Copyright 2023 Springroll Games / Yosi */