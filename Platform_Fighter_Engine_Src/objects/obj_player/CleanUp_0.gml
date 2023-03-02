///@description Destroy resources
sync_id_release();

//Reset variables
input_buffer = noone;
my_hitboxes = noone;
state_log = noone;
my_states = noone;
my_attacks = noone;
my_sprites = noone;
attack_cooldowns = noone;
attack_uses = noone;

//Please note: Set data structures to noone instead of undefined to prevent a silent crash with ds_exists.
/* Copyright 2023 Springroll Games / Yosi */