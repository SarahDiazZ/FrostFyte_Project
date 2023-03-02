///@category Animations
/*
Resets the animation of the calling player to the "normal" values and the player's Idle sprite.
If the Idle sprite is an animation array, then the player's animation will be set to those values.
*/
function anim_reset() {
	anim_set(my_sprites[$ anim_state_normal], anim_frame_normal, anim_speed_normal, anim_scale_normal, anim_angle_normal, anim_alpha_normal, anim_offset_normal, anim_offset_normal, anim_loop_normal, anim_finish_normal);
}
/* Copyright 2023 Springroll Games / Yosi */